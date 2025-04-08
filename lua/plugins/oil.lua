-- Cache for Git status per directory
local git_cache = {}
local git_root_cache = nil
local gitignore_patterns_cache = nil
local gitignore_mtime_cache = nil

-- Returns the git root and caches it.
local function get_git_root()
  if git_root_cache then
    return git_root_cache
  end
  local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 then
    git_root_cache = root
    return root
  else
    vim.notify("Not in a git repository", vim.log.levels.WARN)
    return nil
  end
end

-- Function to get the modification time of .gitignore
local function get_gitignore_mtime()
  local git_root = get_git_root()
  if not git_root then
    return nil
  end
  local gitignore_path = git_root .. '/.gitignore'
  local stat = vim.loop.fs_stat(gitignore_path)
  return stat and stat.mtime.sec or nil
end

-- Function to invalidate all caches
local function invalidate_caches()
  git_cache = {}
  gitignore_patterns_cache = nil
  gitignore_mtime_cache = nil
end

-- Returns cached git status for the directory.
local function get_git_status(dir)
  if git_cache[dir] then
    return git_cache[dir]
  end

  local tracked = {}
  local ignored = {}

  -- Get tracked files
  local tracked_list = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " ls-files")
  if vim.v.shell_error == 0 then
    for _, file in ipairs(tracked_list) do
      tracked[vim.fn.fnamemodify(file, ":t")] = true
    end
  end

  -- Get ignored files using git status
  local status_list = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " status --porcelain --ignored --untracked-files=all .")
  if vim.v.shell_error == 0 then
    for _, line in ipairs(status_list) do
      local status = line:sub(1, 2)
      local file = line:sub(4)
      file = vim.fn.fnamemodify(file, ":t")
      -- '!!' means ignored
      if status == "!!" then
        ignored[file] = true
      end
    end
  end

  local status = { tracked = tracked, ignored = ignored }
  git_cache[dir] = status
  return status
end

-- Loads .gitignore patterns fresh from the repository root.
local function load_gitignore_patterns()
  -- Check if we can use cached patterns
  local current_mtime = get_gitignore_mtime()
  if gitignore_patterns_cache and gitignore_mtime_cache and current_mtime and gitignore_mtime_cache == current_mtime then
    return gitignore_patterns_cache
  end

  local git_root = get_git_root()
  if not git_root then
    return {}
  end
  local gitignore_path = git_root .. '/.gitignore'
  local f = io.open(gitignore_path, "r")
  if not f then
    return {}
  end
  local patterns = {}

  for line in f:lines() do
    line = vim.trim(line)
    if line ~= "" and not vim.startswith(line, "#") then
      table.insert(patterns, line)
    end
  end
  f:close()

  -- Cache the patterns and mtime
  gitignore_patterns_cache = patterns
  gitignore_mtime_cache = current_mtime
  
  -- Since gitignore changed, invalidate git status cache
  git_cache = {}

  return patterns
end

-- Given an absolute file path and a base path, returns the file's relative path.
local function get_relative_path(path, base)
  -- Normalize paths to remove any trailing slashes
  path = vim.fn.fnamemodify(path, ":p")
  base = vim.fn.fnamemodify(base, ":p")
  
  -- Remove the base path prefix to get the relative path
  local relative = path:sub(#base + 1)
  -- Remove leading slash if present
  if relative:sub(1, 1) == "/" then
    relative = relative:sub(2)
  end
  return relative
end

-- Converts a simple glob pattern (like in .gitignore) to a Lua pattern.
local function glob_to_pattern(glob)
  -- Handle directory-specific patterns (ending with /)
  local is_dir = glob:sub(-1) == "/"
  glob = is_dir and glob:sub(1, -2) or glob
  
  local pattern = glob:gsub("([%^%$%(%)%%%.%[%]%+%-])", "%%%1")
  pattern = pattern:gsub("%*%*", ".*")  -- Handle ** pattern first
  pattern = pattern:gsub("%*", "[^/]*")  -- Then handle single *
  pattern = pattern:gsub("%?", ".")
  
  -- If it's a directory pattern, make sure it matches full path components
  if is_dir then
    pattern = pattern .. "/"
  end
  
  -- If pattern doesn't contain a slash, it should match in any directory
  if not glob:find("/") then
    pattern = pattern .. "$"  -- Match exact filename for non-path patterns
  end
  
  return "^" .. pattern
end

-- Checks if a relative file path matches any pattern from .gitignore.
local function file_matches_gitignore(relpath)
  local patterns = load_gitignore_patterns()
  
  for _, pat in ipairs(patterns) do
    local lua_pat = glob_to_pattern(pat)
    if relpath:match(lua_pat) then
      return true
    end
  end
  return false
end

local show_all = false

local function is_hidden_file(name, bufnr)
  if show_all then
    return false
  end

  local dir = require('oil').get_current_dir(bufnr)
  if not dir then
    return false
  end

  -- Always show non-dot files that exist on disk, regardless of git status
  if not vim.startswith(name, '.') and name ~= '..' then
    -- Check if it matches gitignore patterns only if we're in a git repo
    local git_root = get_git_root()
    if git_root then
      -- Get the full path and make it relative to git root
      local full_path = vim.fn.fnamemodify(dir .. "/" .. name, ":p")
      local relpath = get_relative_path(full_path, git_root)
      
      -- Only hide files that match gitignore patterns
      return file_matches_gitignore(relpath)
    end
    return false  -- Not in a git repo, show all non-dot files
  end
  
  -- For dotfiles (starting with .), hide by default unless it's .gitignore
  if name == '.gitignore' then
    return false
  end
  
  -- If we're in a git repo, check if the dotfile is tracked
  local git_root = get_git_root()
  if git_root then
    local status = get_git_status(dir)
    -- Show dotfiles that are tracked by git
    return not status.tracked[name]
  end
  
  -- In non-git repos, hide all dotfiles
  return true
end

local function toggle_show_all()
  show_all = not show_all
  require('oil').refresh()
end

return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      show_hidden = false,
      is_hidden_file = is_hidden_file,
    },
    keymaps = {
      ['s'] = "actions.toggle_hidden",
    },
  },
  keys = {
    { '<leader>E', function()
        local root = get_git_root()
        if root then
          vim.cmd.Oil(root)
        end
      end },
    { '<leader>e', '<cmd>Oil<cr>' },
  },
  event = function()
    if vim.fn.isdirectory(vim.fn.expand('%:p')) == 1 then
      return 'VimEnter'
    end
  end,
}

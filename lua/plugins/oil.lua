-- Thanks barrett-ruth for inspiration. 
local git_cache = {}

local function get_git_status(dir)
  if git_cache[dir] then
    return git_cache[dir]
  end

  local tracked = {}
  local ignored = {}

  local tracked_list = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " ls-files")
  if vim.v.shell_error == 0 then
    for _, file in ipairs(tracked_list) do
      tracked[file] = true
    end
  end

  local ignored_list = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " ls-files --others --ignored --exclude-standard")
  if vim.v.shell_error == 0 then
    for _, file in ipairs(ignored_list) do
      ignored[file] = true
    end
  end

  local status = { tracked = tracked, ignored = ignored }
  git_cache[dir] = status
  return status
end

local function clear_git_cache()
  git_cache = {}
end

local git_root_cache = nil
local function get_git_root()
    if git_root_cache then return git_root_cache end
    local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    if vim.v.shell_error == 0 then
        git_root_cache = root
        return root
    else
        vim.notify("Not in a git repository", vim.log.levels.WARN)
        return nil
    end
end

local show_all = false

local function is_hidden_file(name, bufnr)
    if show_all then
        return false
    end

    local dir = require('oil').get_current_dir(bufnr)
    if not dir then return false end

    local status = get_git_status(dir)

    -- only show dotfiled if tracked
    if vim.startswith(name, '.') and name ~= '..' then
        return not status.tracked[name]
    end

    return status.ignored[name] == true
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

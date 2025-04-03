local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set up Mason path during startup to ensure it's always available
local mason_path = vim.fn.expand("~/.local/share/nvim/mason")
local mason_bin = mason_path .. "/bin"
-- Prepend to PATH to ensure Mason binaries are found first
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
-- Make executable permissions explicit to avoid issues
vim.fn.system("chmod +x " .. mason_bin .. "/*")

-- Leader key
vim.g.mapleader = " "

-- Custom error handler to suppress annoying LSP errors
local old_notify = vim.notify
vim.notify = function(msg, level, opts)
    if msg and msg:match("Spawning language server with cmd.*pylsp.*failed") then
        -- Don't show this error
        return
    end
    -- Forward other messages to the original handler
    return old_notify(msg, level, opts)
end

require("lua.settings")
require("lazy").setup("plugins", {
    -- Load order: mason first, then lspconfig
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
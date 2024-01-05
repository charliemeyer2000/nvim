vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
-- make shift + tab be unindent
vim.api.nvim_set_keymap("i", "<S-Tab>", "<C-D>", { noremap = true, silent = true })
-- add line numbers
vim.cmd("set number")
-- make yank also copy to system clipboard
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set autoindent")

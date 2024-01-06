vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set smarttab")
vim.cmd("set autoindent")


vim.g.mapleader = " "
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
-- make shift + tab be unindent
vim.api.nvim_set_keymap("i", "<S-Tab>", "<C-D>", { noremap = true, silent = true })
-- add line numbers
vim.cmd("set relativenumber number")
-- make yank also copy to system clipboard
vim.cmd("set clipboard+=unnamedplus")
-- jj to exit insert
vim.cmd("inoremap jj <Esc>")

-- turn off highlight until next search
vim.cmd("set nohlsearch")

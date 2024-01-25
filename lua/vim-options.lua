vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set smarttab")
vim.cmd("set autoindent")
vim.cmd("set syntax=on")
-- if you git pull something, it should auto reload
vim.cmd("set autoread")
vim.cmd("au CursorHold * checktime")

vim.g.mapleader = " "
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
-- this doesn't work idk why though
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
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

-- set command + w to close buffer
vim.cmd("nnoremap <silent> <C-w> :BufferClose<CR>")


# Neovim Configuration Reference

## Global Mappings
- Leader Key: `<Space>`
- Exit insert mode: `jj`

## Commands
- `:checkhealth` - Check for issues with Neovim and plugins
- `:Lazy` - Open lazy.nvim plugin manager
- `:Mason` - Manage LSP servers, formatters, and linters
- `:MasonUpdate` - Update Mason packages
- `:TSUpdate` - Update treesitter parsers
- `:LspInfo` - Show LSP client information for current buffer
- `:LazyGit` - Open lazygit interface

## File Navigation
### Telescope
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Browse buffers
- `<leader>fh` - Search help tags

### Oil
- `<leader>e` - Open oil file explorer at current location
- `<leader>E` - Open oil at git root
- `s` - Toggle hidden files in oil browser

## LSP and Code Navigation
### LSP
- `gD` - Go to declaration
- `gd` - Go to definition
- `K` - Show hover documentation
- `gi` - Go to implementation
- `<C-k>` - Show signature help
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `gr` - Show references
- `<leader>f` - Format document
- `<leader>cd` - Show line diagnostics
- `[e` - Jump to previous diagnostic
- `]e` - Jump to next diagnostic

### Completion (nvim-cmp)
- `<C-d>/<C-f>` - Scroll docs down/up
- `<C-Space>` - Complete
- `<CR>` - Confirm completion
- `<Tab>/<S-Tab>` - Next/previous completion item

### Treesitter
Incremental Selection:
- `grn` - Initialize selection/expand node
- `grm` - Shrink selection to previous node
- `grc` - Expand to scope

Text Objects:
- `af`/`if` - Function outer/inner
- `ac`/`ic` - Class outer/inner
- `al`/`il` - Loop outer/inner
- `aa`/`ia` - Parameter outer/inner

Navigation:
- `]f`/`[f` - Next/previous function
- `]c`/`[c` - Next/previous class

## Git Integration
- `<leader>lg` - Open lazygit

## Automatic Features
- Format on save (enabled by default)
- Auto-installation of LSP servers, formatters, and linters
- Auto-detection of file type and indentation (vim-sleuth)
- Auto-pairing of brackets and quotes (mini.pairs)
- Auto tag completion/rename for HTML/JSX

## Code Style Guidelines
- Indentation: 2 spaces (not tabs)
- Line length: Keep below 100 characters
- Plugin configs: Use return table pattern
- Naming: Use snake_case for variables and functions
- Function calls: Prefer comma-first style for multiline
- Keep plugins organized in separate files under lua/plugins/
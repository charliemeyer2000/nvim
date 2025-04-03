# Neovim Configuration Guidelines

## Commands
- `:checkhealth` - Check for issues with Neovim and plugins
- `:Lazy` - Open lazy.nvim plugin manager
- `:Mason` - Manage LSP servers, formatters, and linters
- `:TSUpdate` - Update treesitter parsers
- `:LspInfo` - Show LSP client information for current buffer

## Code Style
- Indentation: 2 spaces (not tabs)
- Line length: Keep below 100 characters
- Plugin configs: Use return table pattern
- Naming: Use snake_case for variables and functions
- Function calls: Prefer comma-first style for multiline
- Keep plugins organized in separate files under lua/plugins/

## LSP Keybindings
- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>f` - Format buffer
- `gr` - Find references
- `[e` and `]e` - Jump between diagnostics

## Formatting
- Format on save is enabled by default
- `<leader>f` triggers manual formatting
- Mason automatically installs formatters and linters

This config uses lazy.nvim for plugin management with modular organization.
return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
      vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
      -- also set the background to none when in split mode with multiple windows
      vim.cmd [[ au VimEnter,WinEnter,BufWinEnter * if winnr('$') > 1 | setlocal winhighlight=Normal:NormalFloat,NormalNC:NormalFloat | endif ]]
      
    end
  }
}

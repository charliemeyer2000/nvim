-- return {
--   {
--     'wilmanbarrios/palenight.nvim',
--     lazy = false,
--     name = "palenight",
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme "palenight"
--       vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
--       vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
--       -- also set the background to none when in split mode with multiple windows
--       vim.cmd [[ au VimEnter,WinEnter,BufWinEnter * if winnr('$') > 1 | setlocal winhighlight=Normal:NormalFloat,NormalNC:NormalFloat | endif ]]
--     end
--   }
-- }
return {
}

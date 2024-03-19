return {
    {
        "datsfilipe/vesper.nvim",
        lazy = false,
        priority = 1000,
        name = "vesper",
        config = function()
            require("vesper").setup({
                transparent = true,
            })

            vim.cmd.colorscheme("vesper")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            -- also set the background to none when in split mode with multiple windows
            vim.cmd(
                [[ au VimEnter,WinEnter,BufWinEnter * if winnr('$') > 1 | setlocal winhighlight=Normal:NormalFloat,NormalNC:NormalFloat | endif ]]
            )
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
        end,
    },
}

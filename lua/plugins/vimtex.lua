return {
    "lervag/vimtex",
    config = function()
        -- local vimtex = require("vimtex")
        -- vimtex_view_general_viewer
        vim.g.vimtex_view_method = "skim"
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_view_skim_sync = 1
        vim.g.vimtex_view_skim_activate = 1
        -- compilation
        vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>", { noremap = true, silent = true })
        -- latexmk options
        -- vim.g.vimtex_compiler_latexmk = {
        --     options = {
        --         '-verbose', 
        --         '-file-line-error',
        --         'synctex=1', 
        --         'interaction=nonstopmode',
        --         
        --     }
        -- }
        -- pdf creation
        vim.keymap.set("n", "<leader>lc", ":VimtexCompile<CR>:VimtexView<CR>", { noremap = true, silent = true })

        -- pdf view
        vim.keymap.set("n", "<leader>lv", ":VimtexView<CR>", { noremap = true, silent = true })
    end,
}

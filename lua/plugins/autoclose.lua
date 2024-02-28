-- auto closes brackets and quotes and stuff
return {
    "m4xshen/autoclose.nvim",
    config = function()
        require("autoclose").setup({
            options = {
                disabled_filetypes = { "text" },
                auto_indent = false,
            },
        })
    end,
}


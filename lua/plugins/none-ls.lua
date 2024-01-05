return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
        -- python autoppep8
        null_ls.builtins.formatting.black,
        -- use prettier for javascript
        null_ls.builtins.formatting.prettier,
        -- use prettier for typescript
        null_ls.builtins.formatting.prettierd,
        -- use prettier for json
        null_ls.builtins.formatting.prettierd,
			},

		})

		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
    -- formatting on save
	end,
}

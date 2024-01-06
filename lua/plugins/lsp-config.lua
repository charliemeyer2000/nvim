return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").pyright.setup({
				settings = {
					pyright = {
						autoImportCompletion = true,
					},
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							typeCheckingMode = "off",
						},
					},
				},
			})
			require("lspconfig").tsserver.setup({})
			require("lspconfig").gopls.setup({})
			require("lspconfig").rust_analyzer.setup({})
			require("lspconfig").clangd.setup({})
			require("lspconfig").vimls.setup({})
			require("lspconfig").bashls.setup({})
			require("lspconfig").yamlls.setup({})
			require("lspconfig").jsonls.setup({})
			require("lspconfig").html.setup({})
			require("lspconfig").cssls.setup({})
			require("lspconfig").dockerls.setup({})
			require("lspconfig").terraformls.setup({})
			require("lspconfig").graphql.setup({})
			require("lspconfig").lua_ls.setup({})
			require("lspconfig").vimls.setup({})
			require("lspconfig").vuels.setup({})
			require("lspconfig").dartls.setup({})
			require("lspconfig").jdtls.setup({})
			require("lspconfig").solargraph.setup({})
			require("lspconfig").elixirls.setup({})
			require("lspconfig").clojure_lsp.setup({})
			require("lspconfig").nimls.setup({})
			require("lspconfig").hls.setup({})
			require("lspconfig").cmake.setup({})
			require("lspconfig").r_language_server.setup({})
			require("lspconfig").svelte.setup({})
			require("lspconfig").tailwindcss.setup({})
			require("lspconfig").sorbet.setup({})
			require("lspconfig").leanls.setup({})
			require("lspconfig").sqlls.setup({})
			require("lspconfig").dartls.setup({})
			require("lspconfig").julials.setup({})
			require("lspconfig").jedi_language_server.setup({})
			require("lspconfig").nimls.setup({})
			require("lspconfig").hls.setup({})
			require("lspconfig").cmake.setup({})
			require("lspconfig").r_language_server.setup({})
			require("lspconfig").svelte.setup({})
			require("lspconfig").tailwindcss.setup({})
			require("lspconfig").sorbet.setup({})
			require("lspconfig").leanls.setup({})
			require("lspconfig").sqlls.setup({})
			-- keybindings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
		end,
	},
}

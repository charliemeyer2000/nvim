return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	-- init = function() vim.g.barbar_auto_setup = false end,
	config = function()
		require("barbar").setup({
			animation = false,
			clickable = true,
			no_name_title = "new_file.txt",
		})

		-- add transparency to the floating file tabs
		vim.cmd("hi BufferTabpageFill ctermbg=black")
	end,
}

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-b>", ":Neotree filesystem reveal left toggle<CR>", {})
		vim.keymap.set("n", "<C-g>", ":Neotree git_status reveal left toggle<CR>", {})
    -- setup neotree
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = false,
      -- showing gitignore
      filesystem = {
        filtered_items = {
          visible = true,
          always_show = {
            ".gitignore", ".env", ".env", ".env.*", ".git"
          }
        }
      }
    })
	end,
}

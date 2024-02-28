-- allows you to surround text with symbols
return {

	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
            
        })
	end,
}

-- the pretty status bar at the bottom that shows language, git branch, etc.
return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup({
      options = {
        theme = 'dracula'
      }
    })
  end
}


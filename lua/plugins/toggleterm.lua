return {
  "akinsho/toggleterm.nvim",
  -- tag = "*",
  config = function()
    require("toggleterm").setup({
      size = vim.o.columns * 0.5,
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_filetypes = {},
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
    })
  end,
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local keymap = vim.keymap
      local opts = { noremap = true, slient = true }
      local on_attach = function(client, bufnr)
        opts.bufnr = bufnr
        opts.desc = "Show LSP references"
        keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Show documentation for what is under cursor"
--        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        
      end
      -- setup python
      require("lspconfig").pyright.setup({
        --capabilities = capabilities,
        on_attach = on_attach
      })
      -- setup lua
      require("lspconfig").lua_ls.setup({
        --capabilities = capabilities,
      })
      -- setup typescript
      require("lspconfig").tsserver.setup({
        -- capabilities = capabilities,
      })
      -- setup html
      require("lspconfig").html.setup({
        -- capabilities = capabilities,
      })
      -- setup css
      require("lspconfig").cssls.setup({
        capabilities = capabilities
      })
      -- setup json
      require("lspconfig").jsonls.setup({
        -- capabilities = capabilities
      })
      -- setup yaml
      require("lspconfig").yamlls.setup({
        -- capabilities = capabilities
      })
      -- setup docker
      require("lspconfig").dockerls.setup({
        -- capabilities = capabilities
      })
      -- setup bash
      require("lspconfig").bashls.setup({
        -- capabilities = capabilities

      })
      -- setup vim
      require("lspconfig").vimls.setup({
        -- capabilities = capabilities
      })
      -- setup c
      require("lspconfig").clangd.setup({
        -- capabilities = capabilities
      })
      -- setup cpp
      require("lspconfig").clangd.setup({
        -- capabilities = capabilities
      })
      -- setup rust
      require("lspconfig").rust_analyzer.setup({
        -- capabilities = capabilities
      })
      -- setup go
      require("lspconfig").gopls.setup({
        -- capabilities = capabilities
      })
    end,
  }
}

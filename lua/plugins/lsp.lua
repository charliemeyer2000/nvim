return {
  -- LSP Management with automatic setup
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    priority = 1000, -- Super high priority to load first
    lazy = false,  -- Load during startup, not lazy
    config = function()
      -- Ensure executable permissions
      local mason_bin = vim.fn.expand("~/.local/share/nvim/mason/bin")
      if vim.fn.isdirectory(mason_bin) == 1 then
        vim.fn.system("chmod +x " .. mason_bin .. "/*")
      end

      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        PATH = "prepend", -- Prepend to PATH to ensure Mason binaries are found first
        install_root_dir = vim.fn.stdpath("data") .. "/mason",
      })

      -- Wait briefly after Mason loads to ensure it's ready
      vim.defer_fn(function()
        -- Refresh env PATH to ensure it's available to LSP
        vim.cmd("let $PATH='" .. vim.env.PATH .. "'")
      end, 500)
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = "VeryLazy", -- Delay loading until after Mason is ready
    config = function()
      -- Set up LSP keymaps - defined first so it's available to all servers
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Key mappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

        -- Format command
        if client.server_capabilities.documentFormattingProvider then
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)

          -- Format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      -- LSP handler customizations
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      -- Setup capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      end

      -- Make sure paths are absolute for all commands
      local mason_bin = vim.fn.expand("~/.local/share/nvim/mason/bin")

      -- Auto-install configurations
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "pyright", -- Python
          "ts_ls", -- TypeScript/JavaScript
          "html", -- HTML
          "cssls", -- CSS
          "clangd", -- C/C++
        },
        automatic_installation = true,
      })

      -- Wait for Mason to complete installations
      vim.defer_fn(function()
        require("mason-lspconfig").setup_handlers({
          -- Default handler for all servers
          function(server_name)
            local server_path = mason_bin .. "/" .. server_name
            if server_name == "pyright" then
              server_path = mason_bin .. "/pyright-langserver"
            elseif server_name == "tsserver" then
              server_path = mason_bin .. "/typescript-language-server"
            end

            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
              handlers = handlers,
              cmd = server_name == "pyright" and { mason_bin .. "/pyright-langserver", "--stdio" } or nil,
            })
          end,

          -- Custom server configurations
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              handlers = handlers,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              },
            })
          end,
        })
      end, 1000) -- Wait 1 second to ensure Mason installations are complete
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback() -- If no completion menu is visible, just do a regular <CR>
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },

  -- Linting and formatting
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        border = "rounded",
        sources = {
          -- Formatters
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.clang_format,
        },
        -- Format on save (also available via LSP keymaps)
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },

  -- Automatic installation of formatters, linters, etc.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "prettier",
          "black",
          "stylua",
          "clang-format",
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },

  -- LSP UI improvements
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
        },
        symbol_in_winbar = {
          enable = true,
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = true,
        },
      })

      -- Additional keymaps with Lspsaga
      vim.keymap.set("n", "gh", "<cmd>Lspsaga finder<CR>")
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
      vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
      vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
      vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")
      vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    end,
  },
}


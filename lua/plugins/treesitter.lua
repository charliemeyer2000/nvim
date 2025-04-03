return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        -- all folds open
        vim.opt.foldlevel = 99

        configs.setup({
            ensure_installed = "all",
            sync_install = false,
            highlight = { 
                enable = true,
                -- disable for large files
                disable = function(_, bufnr)
                    local lines = vim.api.nvim_buf_line_count(bufnr)
                    return lines > 5000
                end,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "grn", -- init selection
                    node_incremental = "grn", -- next textobject
                    node_decremental = "grm", -- previous textobject
                    scope_incremental = "grc", -- next scope
                },
            },
            -- Add basic textobjects support
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, 
                    goto_next_start = {
                        ["]f"] = "@function.outer", -- next function
                        ["]c"] = "@class.outer", -- next class
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer", -- previous function
                        ["[c"] = "@class.outer", -- previous class
                    },
                },
            },
            -- auto tag completion/rename for HTML/JSX
            autotag = {
                enable = true,
            },
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag", -- JSX auto tag close/rename
    },
}
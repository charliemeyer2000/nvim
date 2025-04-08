return {
    "echasnovski/mini.pairs", version = "*",
    config = function()
        require("mini.pairs").setup({
            -- Disable auto-pairing for triple quotes in Python
            mappings = {
                ['"'] = { action = 'open', pair = '""', neigh_pattern = '[^\\].' },
            }
        })
    end
}
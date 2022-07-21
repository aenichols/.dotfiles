local minimal = require("rooster.minimal")
require("zen-mode").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    window = {
        backdrop = 0.35,
        width = 200,
        options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
        },
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = minimal.turn_off_guides,
    -- callback where you can add custom code when the Zen window closes
    on_close = minimal.turn_off_guides,
}

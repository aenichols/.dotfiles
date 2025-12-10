return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        -- harpoon 2
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            print("Harpoon added file " .. vim.fn.expand("%:t"))
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<leader>A", function()
            print("Harpoon added file " .. vim.fn.expand("%:t"))
            harpoon:list():prepend()
        end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)

        -- harpoon - ext - legacy honor
        local term = require("rooster.harpoon-ext")
        vim.keymap.set("n", "<leader>ta", function() term.gotoTerminal({ idx = 1 }) end)
        vim.keymap.set("n", "<leader>ts", function() term.gotoTerminal({ idx = 2 }) end)
        vim.keymap.set("n", "<leader>el", function()
            -- get current file path
            local file_path = vim.fn.expand("%")
            term.sendCommand({ idx = 1 }, "npx eslint " .. file_path .. "\r")
        end)
        vim.keymap.set("n", "<leader>elf", function()
            -- get current file path
            local file_path = vim.fn.expand("%")
            term.sendCommand({ idx = 1 }, "npx eslint --fix " .. file_path .. "\r")
        end)
    end
}

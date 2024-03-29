-- harpoon 1 - aenichols
--
-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
-- local term = require("harpoon.term")
-- local cmd = require("harpoon.cmd-ui")

-- vim.keymap.set("n", "<leader>a", mark.add_file)
-- vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
-- vim.keymap.set("n", "<leader>tc", function() cmd.toggle_quick_menu() end)
--
-- vim.keymap.set("n", "<leader>g7", function() require("harpoon.ui").nav_file(1) end)
-- vim.keymap.set("n", "<leader>g8", function() require("harpoon.ui").nav_file(2) end)
-- vim.keymap.set("n", "<leader>g9", function() require("harpoon.ui").nav_file(3) end)
-- vim.keymap.set("n", "<leader>g0", function() require("harpoon.ui").nav_file(4) end)

-- harpoon - ext - legacy honor
local term = require("rooster.harpoon-ext")
vim.keymap.set("n", "<leader>ta", function() term.gotoTerminal({ idx = 1 }) end)
vim.keymap.set("n", "<leader>ts", function() term.gotoTerminal({ idx = 2 }) end)

-- harpoon 2
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>g7", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>g8", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>g9", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>g0", function() harpoon:list():select(4) end)

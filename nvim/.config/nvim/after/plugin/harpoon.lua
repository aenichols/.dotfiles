local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")
local cmd = require("harpoon.cmd-ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>tc", function() cmd.toggle_quick_menu() end)

vim.keymap.set("n", "<C-7>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-8>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-9>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-0>", function() ui.nav_file(4) end)

vim.keymap.set("n", "<leader>ta", function() term.gotoTerminal({ idx = 1 }) end)
vim.keymap.set("n", "<leader>ts", function() term.gotoTerminal({ idx = 2 }) end)

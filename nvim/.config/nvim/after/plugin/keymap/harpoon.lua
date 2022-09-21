local nnoremap = require("rooster.keymap").nnoremap

local silent = { silent = true }

-- Terminal commands
-- ueoa is first through fourth finger left hand home row.
-- This just means I can crush, with opposite hand, the 4 terminal positions
--
-- These functions are stored in harpoon.  A plugn that I am developing
nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent)
nnoremap("<leader>tc", function() require("harpoon.cmd-ui").toggle_quick_menu() end, silent)

-- UI
nnoremap("<C-h>7", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<C-h>8", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<C-h>9", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<C-h>0", function() require("harpoon.ui").nav_file(4) end, silent)

-- Terminal
nnoremap("<leader>ta", function() require("harpoon.term").gotoTerminal({ idx = 1 }) end, silent)
nnoremap("<leader>ts", function() require("harpoon.term").gotoTerminal({ idx = 2 }) end, silent)
nnoremap("<leader>cd", function() require("harpoon.term").sendCommand(1, 1) end, silent)
nnoremap("<leader>ce", function() require("harpoon.term").sendCommand(1, "eslint --fix") end, silent)

-- ############################################################################
-- #ROOSTER                                                                   #
-- ############################################################################

nnoremap("<leader>vesl", function() require("harpoon.term").sendCommand(2, "eslint --fix " ..vim.fn.getreg('%')); require("harpoon.term").gotoTerminal(2) end, silent)

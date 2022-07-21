local neogit = require('neogit')
local nnoremap = require('rooster.keymap').nnoremap

neogit.setup {}

nnoremap("<leader>gs", function()
    neogit.open({ kind = "floating" })
end);

nnoremap("<leader>gfa", "<cmd>!git fetch --all<CR>");

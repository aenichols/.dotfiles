local neogit = require('neogit')
local nnoremap = require('rooster.keymap').nnoremap

neogit.setup {}

nnoremap("<leader>gs", function()
    neogit.open({ kind = "split_above" })
end);

nnoremap("<leader>gfa", "<cmd>!git fetch --all<CR>");

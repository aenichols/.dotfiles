local nnoremap = require('rooster.keymap').nnoremap

nnoremap("<leader>gs", ":G<CR>");
nnoremap("<leader>gfa", "<cmd>!git fetch --prune --all --progress<CR>");

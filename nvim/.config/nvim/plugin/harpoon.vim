lua require("theprimeagen")

" Terminal commands
" ueoa is first through fourth finger left hand home row.
" This just means I can crush, with opposite hand, the 4 terminal positions
"
" These functions are stored in harpoon.  A plugn that I am developing
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <C-h>7 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <C-h>8 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <C-h>9 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <C-h>0 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>ta :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>ts :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>cd :lua require("harpoon.term").sendCommand(1, 1)<CR>
nnoremap <leader>ce :lua require("harpoon.term").sendCommand(1, "eslint --fix")<CR>


nnoremap <C-Left> :call AfPPAlternatePluthPluth()<CR>
nnoremap <C-Up> :call AfPPAlternate()<CR>
inoremap <C-Left> <esc>:call AfPPAlternatePluthPluth()<CR>
inoremap <C-Up> <esc>:call AfPPAlternate()<CR>
nnoremap <C-k> :cnext<CR>zz
nnoremap <C-j> :cprev<CR>zz
nnoremap <leader>k :lnext<CR>zz
nnoremap <leader>j :lprev<CR>zz
nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <C-q>l :call ToggleQFList(0)<CR>

let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            let g:the_primeagen_qf_g = 0
            cclose
        else
            let g:the_primeagen_qf_g = 1
            copen
        end
    else
        if g:the_primeagen_qf_l == 1
            let g:the_primeagen_qf_l = 0
            lclose
        else
            let g:the_primeagen_qf_l = 1
            lopen
        end
    endif
endfun

"##############################################################################
"#ROOSTER                                                                      #
"##############################################################################

" May remove
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Maps Ctrl-[Arrows] to resizing a window split
map <silent> <C-M-h> <C-w><
map <silent> <C-M-j> <C-W>-
map <silent> <C-M-k> <C-W>+
map <silent> <C-M-l> <C-w>>

map S ddO
map cc S

"Close buffer
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>qa :bufdo bd<CR>

map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

" Vim Setup Splits
nmap <leader>vss  :wincmd o<CR>:G<CR>gU<CR>:wincmd v<CR>:wincmd H<CR>:wincmd l<CR>:wincmd v<CR>10<C-W>-:wincmd l<CR>:lua require("harpoon.term").gotoTerminal(1)<CR>abash


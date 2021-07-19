fun! ThePrimeagenTurnOnGuides()
    set rnu
    set nu
    set signcolumn=yes
    set colorcolumn=80
    set foldcolumn=2
endfun

fun! ThePrimeagenTurnOffGuides()
    set nornu
    set nonu
    set signcolumn=no
    set colorcolumn=800
    set foldcolumn=0
endfun

nnoremap <leader>ao :call ThePrimeagenTurnOnGuides()<cr>
nnoremap <leader>ae :call ThePrimeagenTurnOffGuides()<cr>

augroup THE_PRIMEAGEN_MINIMAL
    autocmd!
    autocmd FileType *\(^\(netrw\|help\)\)\@<! :call ThePrimeagenTurnOnGuides()
    autocmd FileType netrw,help :call ThePrimeagenTurnOffGuides()
augroup END

"GOYO
autocmd! User GoyoEnter nested call ThePrimeagenTurnOffGuides()
autocmd! User GoyoLeave nested call ThePrimeagenTurnOnGuides()

nnoremap <leader>az :Goyo<cr>


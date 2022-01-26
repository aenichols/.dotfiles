fun! ColorMyPencils()
    lua require("xsvrooster.colors").setup()

    let g:gruvbox_contrast_dark = 'hard'

    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection='0'

    set background=dark
    if has('nvim')
        call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:theprimeagen_colorscheme])

        call luaeval('vim.highlight.create("visual", { ctermbg=0, guibg=white, guifg=black }, false)', [])
    else
        " TODO: What the way to use g:theprimeagen_colorscheme
        colorscheme gruvbox
    endif

    if g:theprimeagen_colorscheme == "tokyodark"
        return
    endif

    " post color setup

    highlight ColorColumn ctermbg=0 guibg=grey
    highlight SignColumn guibg=none
    highlight CursorLineNR guibg=none
    highlight Normal guibg=none
    highlight Folded guibg=none
    highlight FoldColumn guibg=none guifg=#000000

    " highlight LineNr guifg=#ff8659
    " highlight LineNr guifg=#aed75f

    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd
endfun:

call ColorMyPencils()

" Vim with me
nnoremap <leader>cmm :call ColorMyPencils()<CR>
nnoremap <leader>cmb :let g:theprimeagen_colorscheme =

"##############################################################################
"#ROOSTER                                                                     #
"##############################################################################

" Colorize line numbers in insert and visual modes
" ------------------------------------------------
function! SetVisualList()
    set updatetime=0
    " Set list
    set list
    " move cursor to force an update
    return 'lh'
endfunction

function! ResetVisualList()
    set updatetime=4000
    set nolist
endfunction

vnoremap <silent> <expr> <SID>SetVisualList SetVisualList()
nnoremap <silent> <script> v v<SID>SetVisualList
nnoremap <silent> <script> V V<SID>SetVisualList
nnoremap <silent> <script> <C-v> <C-v><SID>SetVisualList

augroup CursorLineNrColorSwap
    autocmd!
    " Reset list when leaving insert mode from visual block mode
    autocmd InsertEnter *.* call ResetVisualList()
    " Reset list when idle in normal mode
    " This wiil cause the start screen to disappear
    autocmd CursorHold *.* call ResetVisualList()
augroup END


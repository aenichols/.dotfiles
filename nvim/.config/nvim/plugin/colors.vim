let g:theprimeagen_colorscheme = "tokyodark"
fun! ColorMyPencils()
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

    highlight ColorColumn ctermbg=0 guibg=grey
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    highlight Normal guibg=none
    " highlight LineNr guifg=#ff8659
    " highlight LineNr guifg=#aed75f
    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd

    "ROOSTER
    hi CursorColumn guibg=#404040
    hi Search guibg=black guifg=wheat
    hi IncSearch guibg=black guifg=pink
endfun:

call ColorMyPencils()

" Vim with me
nnoremap <leader>cwm :call ColorMyPencils()<CR>
nnoremap <leader>cwb :let g:theprimeagen_colorscheme =

"##############################################################################
"#ROOSTER                                                                     #
"##############################################################################

" Colorize line numbers in insert and visual modes
" ------------------------------------------------
function! SetCursorLineNrColorInsert(mode)
    " Insert mode: blue
    if a:mode == "i"
        highlight CursorLineNr ctermfg=4 guifg=#26d2c4

    " Replace mode: red
    elseif a:mode == "r"
        highlight CursorLineNr ctermfg=1 guifg=#dc322f

    endif
endfunction

function! SetCursorLineNrColorVisual()
  set updatetime=0

  " Visual mode: yellow
  highlight CursorLineNr cterm=none ctermfg=9 guifg=#d29026

  " Set list
  set list

  return ''
endfunction

function! ResetCursorLineNrColor()
  set updatetime=4000
  highlight CursorLineNr cterm=none ctermfg=0 guifg=#d2c926
  set nolist
endfunction

vnoremap <silent> <expr> <SID>SetCursorLineNrColorVisual SetCursorLineNrColorVisual()
nnoremap <silent> <script> v v<SID>SetCursorLineNrColorVisual
nnoremap <silent> <script> V V<SID>SetCursorLineNrColorVisual
nnoremap <silent> <script> <C-v> <C-v><SID>SetCursorLineNrColorVisual

augroup CursorLineNrColorSwap
    autocmd!
    autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
    autocmd InsertLeave * call ResetCursorLineNrColor()
    autocmd CursorHold * call ResetCursorLineNrColor()
augroup END


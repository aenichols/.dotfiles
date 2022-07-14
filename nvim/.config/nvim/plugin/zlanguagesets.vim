syntax on

set cursorcolumn

fun! SetCSharp()
  set colorcolumn=160
  " COC remaps
  nnoremap <buffer> gd          :call CocAction('jumpDefinition')<CR>
  nnoremap <buffer> gi          :call CocAction('jumpImplementation')<CR>
  nnoremap <buffer> K           :call CocAction('doHover')<CR>
  nnoremap <buffer> <leader>vws :CocList<CR>
  nnoremap <buffer> <leader>vd  :call CocAction('diagnosticInfo')<CR>
  nnoremap <buffer> [d          :call CocAction('diagnosticNext')<CR>
  nnoremap <buffer> ]d          :call CocAction('diagnosticPrevious')<CR>
  nnoremap <buffer> <leader>vca <Plug>(coc-codeaction-line)
  nnoremap <buffer> <leader>vrr :call CocAction('jumpReferences')<CR>
  nnoremap <buffer> <leader>vrn :call CocAction('rename')<CR>
  inoremap <buffer> <C-h>       :call CocAction('showSignatureHelp')<CR>
endfun:

fun! SetTypeScript()
  set colorcolumn=140
  set tabstop=2 softtabstop=2
  set shiftwidth=2
endfun:

fun! SetHTML()
  set colorcolumn=140
  set tabstop=2 softtabstop=2
  set shiftwidth=2
endfun:

fun! SetRazor()
  set syntax=html
endfun:

fun! SetXaml()
  setf xml
  set colorcolumn=160
endfun:

augroup SetLanguage
    au!
    au BufEnter *               set colorcolumn=800
    au BufEnter *.xaml,*.local  call SetXaml()
    au BufEnter *.cs            call SetCSharp()
    au BufEnter *.css,*.html    call SetHTML()
    au BufEnter *.ts            call SetTypeScript()
augroup END

let g:my_coc_file_types = [ 'cs' ]

function! s:disable_coc_for_type()
	if index(g:my_coc_file_types, &filetype) == -1
	        let b:coc_enabled = 0
	endif
endfunction

augroup CocGroup
	autocmd!
	autocmd BufReadPost * call s:disable_coc_for_type()
augroup end

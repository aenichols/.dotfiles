syntax on

set cursorcolumn

fun! SetCSharp()
  set colorcolumn=160
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
    au BufEnter           *            set colorcolumn=800
    au BufNewFile,BufRead *.xaml       call SetXaml()
    au BufNewFile,BufRead *.cs         call SetCSharp()
    au BufNewFile,BufRead *.css,*.html call SetHTML()
    au BufNewFile,BufRead *.ts         call SetTypeScript()
augroup END

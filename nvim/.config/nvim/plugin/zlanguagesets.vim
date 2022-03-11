syntax on

set cursorcolumn

fun! SetCSharp()
  set colorcolumn=160

            " Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
            " Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
        "Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
            " Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
            " Nnoremap("[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
            " Nnoremap("]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
            " Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
            " Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
            " Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
            " Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  " COC remaps
  " Main
  nnoremap <buffer> gd  :call CocAction('jumpDefinition')<CR>
  nnoremap <buffer> K  :call CocAction('doHover')<CR>
  nnoremap <buffer> <leader>vws :CocList<CR>
  nnoremap <buffer> <leader>vd :call CocAction('diagnosticInfo')<CR>
  nnoremap <buffer> [d  :call CocAction('diagnosticNext')<CR>
  nnoremap <buffer> ]d  :call CocAction('diagnosticPrevious')<CR>
  nnoremap <buffer> <leader>vca :CocAction<CR>
  nnoremap <buffer> <leader>vrr :call CocAction('jumpReferences')<CR>
  nnoremap <buffer> <leader>vrn :call CocAction('rename')<CR>
  inoremap <buffer> <C-h> :call CocAction('showSignatureHelp')<CR>

  " Custom
  nnoremap <buffer> <leader>vi  :call CocAction('jumpImplementation')<CR>
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
    au BufEnter *            set colorcolumn=800
    au BufEnter *.xaml       call SetXaml()
    au BufEnter *.cs         call SetCSharp()
    au BufEnter *.css,*.html call SetHTML()
    au BufEnter *.ts         call SetTypeScript()
augroup END

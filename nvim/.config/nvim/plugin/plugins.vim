" TODO convert to lua
"Tokyo Night
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

"AirLine
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

"Ale
let g:ale_echo_msg_format = '%linter% : %s'
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'typescript': ['eslint'],
\}
let g:ale_disable_lsp = 1
let g:ale_virtualtext_cursor = 1

"Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'netrw://.*']

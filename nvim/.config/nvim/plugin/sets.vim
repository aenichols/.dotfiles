set relativenumber
set hlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
" set noshowmode
set signcolumn=yes
set isfname+=@-@
" set ls=0

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80

"##############################################################################
"#ROOSTER                                                                     #
"##############################################################################
set cursorcolumn

"syntax
syntax on
"xaml
au BufNewFile,BufRead *.xaml   setf xml
"Razor
au BufNewFile,BufRead *.cshtml set syntax=html

set mouse=a

"View hidden characters
:set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

"folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=2
set fillchars=fold:\ ,
set foldlevelstart=20

"Column Ruler Override
autocmd BufEnter *.cs   set colorcolumn=160
autocmd BufEnter *.xaml set colorcolumn=160
autocmd BufEnter *.ts   set colorcolumn=140

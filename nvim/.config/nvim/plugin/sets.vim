set relativenumber
set hlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
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

"global status line
set laststatus=3

set mouse=a

"View hidden characters
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

"folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=2
set fillchars=fold:\ ,
set foldlevelstart=20

command Curl !sh  % >> .out.sh 2>>&1

"##############################################################################

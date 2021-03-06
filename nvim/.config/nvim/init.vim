set path+=**

set path+=~/work/**
set path+=~/.dotfiles/**
set path+=~/.dotfiles-windows/**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

call plug#begin('~/.vim/plugged')

" Yes, I am a sneaky snek now
Plug 'ambv/black'

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'github/copilot.vim'
Plug 'hrsh7th/cmp-copilot'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romr/nvim-treesitter-context'

" Debugger Plugins
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'szw/vim-maximizer'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'rust-lang/rust.vim'
Plug 'darrikonn/vim-gofmt'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'
Plug 'gruvbox-community/gruvbox'
Plug 'luisiacc/gruvbox-baby'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-abolish'

" Telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'vim-conf-live/vimconflive2021-colorscheme'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'tiagovla/tokyodark.nvim'
Plug 'folke/tokyonight.nvim'

" HARPOON!!
Plug 'mhinz/vim-rfc'

" prettier
Plug 'sbdchd/neoformat'

" Adding local modules
Plug 'ThePrimeagen/harpoon'
Plug 'theprimeagen/vim-be-good'
Plug 'theprimeagen/refactoring.nvim'
Plug 'theprimeagen/jvim.nvim'
Plug 'theprimeagen/nvim-treesitter-context'

" should I try another status bar???
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Zen Mode
Plug 'folke/zen-mode.nvim'

" Zen Bones
Plug 'rktjmp/lush.nvim'
Plug 'mcchrish/zenbones.nvim'

" Ale for stupid EsLints
Plug 'w0rp/ale'

" Csharp ??\_(???)_/??
" Plug 'editorconfig/editorconfig-vim'
Plug 'gpanders/editorconfig.nvim'
" Csharp coc.nvim START ==============================================================
" Built in lsp or should I say omnisharp is not ready - many issues =/
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Csharp coc.nvim END ================================================================

" Commenter
Plug 'numToStr/Comment.nvim'

call plug#end()

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

lua require("theprimeagen")
lua require("xsvrooster")

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
let g:vim_be_good_log_file = 1
let g:vim_apm_log = 1

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

nnoremap <silent> Q <nop>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.floaterm').open_float_terminal('bash -c "$DOTFILES/bin/.local/bin/tmux-cht.sh"')<CR>
tnoremap <silent> <C-f> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

nnoremap <leader>vwh :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Ex<CR>
nnoremap <Leader><CR> :so ~/AppData/Local/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>

" TODO change based on language - implement csharp into primes refactor plugin
"nnoremap <Leader>ee oconsole.log(`HALLO ${}`);<esc>hhhi
nnoremap <Leader>ee oSystem.Console.WriteLine($"HALLO {System.Text.Json.JsonSerializer.Serialize()}");<esc>hhhhi

nnoremap <Leader>cpu a%" PRIu64 "<esc>
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <leader>gt <Plug>PlenaryTestFile
nnoremap <leader>vwm :lua require("vim-with-me").init()<CR>
nnoremap <leader>dwm :lua require("vim-with-me").disconnect()<CR>
nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>

nnoremap <leader>x :silent !chmod +x %<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

inoremap <C-c> <esc>

" Rooster maps
" Vim Swap Ends
nnoremap <leader>vse i<CR><ESC>V:m '<-2<CR>gv=gv<ESC>J

fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

" ES
com! W w

cmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_PRIMEAGEN
    autocmd!
    " autocmd BufWritePre *.lua Neoformat
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritePre * %s/$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END


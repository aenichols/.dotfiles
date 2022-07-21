--vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- ############################################################################
-- #ROOSTER                                                                   #
-- ############################################################################

--global status line
vim.g.laststatus = "3"

vim.g.mouse = "a"

--View hidden characters
vim.g.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"

--folding
vim.g.foldmethod = "expr"
vim.g.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.foldcolumn = 2
vim.g.fillchars= "fold:\\ ,"
vim.g.foldlevelstart = 20

--command Curl !sh  % >> .out.sh 2>>&1

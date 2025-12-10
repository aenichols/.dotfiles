--vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

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

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

--global status line
vim.opt.laststatus = 3

--View hidden characters
vim.opt.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"

--folding
vim.opt.foldcolumn = "2"
vim.opt.foldlevelstart = 20
vim.opt.foldmethod = "expr"
vim.opt.fillchars:append({ fold = " "})
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

--lock splits
vim.opt.splitright = true
vim.opt.equalalways = false

--float border
vim.opt.winborder = "solid"

--disable shellslash for windows for dap
--review: might be able to remove - also set in dap config
vim.opt.shellslash = false
vim.defer_fn(function()
  vim.opt.shellslash = false
end, 5000)

-- Set explicit Python host to avoid pyenv warning
vim.g.python3_host_prog = 'C:/Users/anthony.nichols/scoop/apps/python/current/python.exe'

-- Disable optional providers that have path issues on Windows
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- set shada explicitly
vim.opt.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"

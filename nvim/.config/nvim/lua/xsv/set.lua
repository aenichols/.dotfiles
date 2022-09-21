--global status line
vim.opt.laststatus = 3

vim.opt.mouse = "a"

--View hidden characters
vim.opt.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"

--folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fillchars:append({ fold = " "})
vim.opt.foldlevelstart = 20
vim.opt.foldcolumn = "2"

--command Curl !sh  % >> .out.sh 2>>&1


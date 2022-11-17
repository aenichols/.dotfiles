local color = require("xsv.colors")

color.colorMyPencils()

require("catppuccin").setup({
	transparent_background = false,
});

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = 1
vim.g.tokyonight_sidebars = "[ 'qf', 'vista_kind', 'terminal', 'packer' ]"

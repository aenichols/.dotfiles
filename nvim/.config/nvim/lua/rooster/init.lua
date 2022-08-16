local augroup = vim.api.nvim_create_augroup
RoosterGroup = augroup('ROOSTER', {})

require("rooster.set")
require("rooster.packer")
require("rooster.neogit")
require("rooster.fugitive")

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufEnter", "BufWinEnter", "TabEnter"}, {
    group = RoosterGroup,
    pattern = "*.rs",
    callback = function()
        require("lsp_extensions").inlay_hints{}
    end
})

autocmd({"BufWritePre"}, {
    group = RoosterGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

require("rooster.debugger")

-- Minimal
local minimal = require("rooster.minimal")
local min_group = augroup('MINGROUP', {})

autocmd('FileType', {
    group = min_group,
    pattern = '*(^(netrw|help|fugitive))@<!',
    callback = minimal.turn_on_guides,
})
autocmd('FileType', {
    group = min_group,
    pattern = 'netrw,help,fugitive',
    callback = minimal.turn_off_guides,
})

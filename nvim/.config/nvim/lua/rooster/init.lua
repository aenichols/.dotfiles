require("rooster.packer")
require("rooster.set")
require("rooster.remap")
require("rooster.visual-whitespace")
require("rooster.language")
require("rooster.harpoon")

local augroup = vim.api.nvim_create_augroup
local RoosterGroup = augroup('Rooster', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

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

autocmd({"BufWritePre"}, {
    group = RoosterGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Defines behavior for formatting comments
autocmd({"BufWinEnter", "BufRead", "BufNewFile"}, {
    group = RoosterGroup,
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove("o")
    end
})

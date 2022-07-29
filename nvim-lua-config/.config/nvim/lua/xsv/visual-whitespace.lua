local Remap = require("rooster.keymap")
local vnoremap = Remap.vnoremap
local nnoremap = Remap.nnoremap
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

-- Functions
M.setVisualList = function ()
    vim.g.set_visual_list = true
    -- set list
    vim.api.nvim_command("set list")

    -- move cursor to force redraw
    vim.api.nvim_input("lh")
end

M.resetVisualList = function ()
    if vim.g.set_visual_list then
        -- reset list
        vim.api.nvim_command("set nolist")

        -- move cursor to force redraw
        vim.api.nvim_input("lh")
    end
end

local visualws_group = augroup('VISUALWS', {})

autocmd({"ModeChanged"}, {
   group = visualws_group,
   pattern = '[vV\x16]*:*',
   callback = M.resetVisualList,
})

autocmd({"ModeChanged"}, {
   group = visualws_group,
   pattern = '*:[vV\x16]*',
   callback = M.setVisualList,
})

return M

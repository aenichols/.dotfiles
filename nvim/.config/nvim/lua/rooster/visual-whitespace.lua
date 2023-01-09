local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

-- Functions
M.setVisualList = function ()
    vim.g.set_visual_list = true
    vim.api.nvim_command("set list")
    vim.cmd("redraw!")
end

M.resetVisualList = function ()
    if vim.g.set_visual_list then
        vim.api.nvim_command("set nolist")
        vim.cmd("redraw!")
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

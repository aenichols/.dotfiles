local M = {}

M.turn_on_guides = function()
    vim.api.nvim_command('do LanguageGroup BufEnter')
    vim.opt.relativenumber = true
    vim.opt.nu = true
    vim.opt.signcolumn = "yes"
    vim.opt.foldcolumn = "2"
end

M.turn_off_guides = function()
    vim.opt.relativenumber = false
    vim.opt.nu = false
    vim.opt.signcolumn = "no"
    vim.opt.colorcolumn = "800"
    vim.opt.foldcolumn = "0"
end

return M

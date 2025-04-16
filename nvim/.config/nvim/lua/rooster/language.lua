local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Language
local language_group = augroup('LanguageGroup', {})

local fe_setup = function()
    vim.wo.colorcolumn = "160"
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
end

-- HTML, TypeScript
autocmd({"BufEnter"}, {
    group = language_group,
    pattern = '*.css,*.html,*.ts,*.tf,*.scss',
    callback = fe_setup,
})
-- Xaml
autocmd({"BufEnter"}, {
    group = language_group,
    pattern = '*.xaml,*.local',
    callback = function()
        vim.bo.filetype = "xml"
        fe_setup()
    end,
})
-- CSharp
autocmd({"BufEnter"}, {
    group = language_group,
    pattern = '*.cs',
    callback = function()
        vim.wo.colorcolumn = "160"
    end,
})

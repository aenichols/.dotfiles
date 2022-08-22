local Remap = require("rooster.keymap")
local nnoremap = Remap.nnoremap
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local buffer = { buffer = true }

local M = {}

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
    pattern = '*.css,*.html,*.ts',
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
        -- nnoremap("gd", ":call CocAction('jumpDefinition')<CR>", buffer)
        -- nnoremap("gi", ":call CocAction('jumpImplementation')<CR>", buffer)
        -- nnoremap("K", ":call CocAction('doHover')<CR>", buffer)
        -- nnoremap("<leader>vws", ":CocList<CR>", buffer)
        -- nnoremap("<leader>vd", ":call CocAction('diagnosticInfo')<CR>", buffer)
        -- nnoremap("[d", ":call CocAction('diagnosticNext')<CR>", buffer)
        -- nnoremap("]d", ":call CocAction('diagnosticPrevious')<CR>", buffer)
        -- nnoremap("<leader>vca", "<Plug>(coc-codeaction-line)", buffer)
        -- nnoremap("<leader>vrr", ":call CocAction('jumpReferences')<CR>", buffer)
        -- nnoremap("<leader>vrn", ":call CocAction('rename')<CR>", buffer)
        -- nnoremap("<C-h>", ":call CocAction('showSignatureHelp')<CR>", buffer)
    end,
})

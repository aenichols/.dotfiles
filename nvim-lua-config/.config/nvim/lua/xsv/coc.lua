local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Coc
local coc_group = augroup('COCGroup', {})

local disable_coc_for_type = function()
    if 'cs' ~= vim.bo.filetype then
        vim.b.coc_enabled = 0
    end
end

autocmd({"FileType"}, {
    group = coc_group,
    pattern = '*',
    callback = disable_coc_for_type,
})

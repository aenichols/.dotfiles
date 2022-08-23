vim.g.airline_theme='bubblegum'
vim.g.airline_powerline_fonts = 1
vim.g.airline_detect_spell = 1
vim.g["airline#extensions#omnisharp#enabled"] = 1
vim.g["airline#extensions#nvimlsp#enabled"] = 1

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local default_keywords = {
    { id = 'QuickerPay', ico = ' ' },
    { id = 'Identity',   ico = ' ' },
    { id = 'Frontend',   ico = ' ' }
}

-- Functions
local addCWDSection = function ()
    local cwd = vim.loop.cwd()
    for _,v in ipairs(default_keywords) do
        local display = v.id .. " " .. v.ico
        if (string.find(cwd, v.id)) then
            vim.cmd("let g:airline_section_a = airline#section#create_left(['" .. display .."', 'mode',])")
        end
    end
end

local alcwd_group = augroup('ALCWD', {})

autocmd({"VimEnter"}, {
   group = alcwd_group,
   pattern = '*',
   callback = addCWDSection,
})

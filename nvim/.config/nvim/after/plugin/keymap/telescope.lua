local Remap = require("rooster.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>ps", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)

nnoremap("<C-p>", function()
    require('telescope.builtin').git_files()
end)

nnoremap("<Leader>pf", function()
    require('telescope.builtin').find_files()
end)

nnoremap("<leader>pw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)

nnoremap("<leader>pb", function()
    require('telescope.builtin').buffers()
end)

nnoremap("<leader>vh", function()
    require('telescope.builtin').help_tags()
end)

nnoremap("<leader>vrc", function()
    require('rooster.telescope').search_dotfiles({ hidden = true })
end)

nnoremap("<leader>va", function()
    require('rooster.telescope').anime_selector()
end)

nnoremap("<leader>gc", function()
    require('rooster.telescope').git_branches()
end)

nnoremap("<leader>glc", function()
    require('xsv.telescope').git_local_branches()
end)

nnoremap("<leader>vpp", function()
    require('xsv.telescope').search_private_proxy()
end)

nnoremap("<leader>vcr", function()
    require('xsv.telescope').search_curl_requests()
end)


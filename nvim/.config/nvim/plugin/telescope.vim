lua require("theprimeagen")

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vht :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vrc :lua require('theprimeagen.telescope').search_dotfiles({ hidden = true })<CR>
nnoremap <leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
nnoremap <leader>gc :lua require('theprimeagen.telescope').git_branches()<CR>

nnoremap <leader>glc :lua require('theprimeagen.telescope').git_local_branches()<CR>
nnoremap <leader>vpp :lua require('theprimeagen.telescope').search_private_proxy()<CR>
nnoremap <leader>vcr :lua require('theprimeagen.telescope').search_curl_requests()<CR>

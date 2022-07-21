vim.g.ale_echo_msg_format = '%linter% : %s'
vim.g.ale_linters_explicit = 1
vim.g.ale_linters = {
    typescript = { 'eslint' },
}
vim.g.ale_disable_lsp = 1
vim.g.ale_virtualtext_cursor = 1

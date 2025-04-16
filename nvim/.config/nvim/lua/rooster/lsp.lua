vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    signs = {
        text = {
            [vim.diagnostic.severity.HINT] = '»',
            [vim.diagnostic.severity.INFO] = '⚑',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.ERROR] = '✘',
        }
    }
})

local function custom_on_publish_diagnostics(_, params, ctx)
    if params.diagnostics then
        local filtered_diagnostics = {}
        local ignore_codes = { -9910002 } -- structual directive error

        for _, diagnostic in ipairs(params.diagnostics) do
            if not vim.tbl_contains(ignore_codes, diagnostic.code) then
                table.insert(filtered_diagnostics, diagnostic)
            end
        end

        params.diagnostics = filtered_diagnostics
    end

    vim.lsp.diagnostic.on_publish_diagnostics(_, params, ctx)
end

-- Severity limit override- report Error, Warning, Information < Hint -- neovim.lsp.protocol.DiagnosticSeverity
-- vim.lsp.diagnostic.on_publish_diagnostics = custom_on_publish_diagnostics; Does not work like I though.
---@diagnostic disable-next-line: deprecated
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {
    virtual_text = { min = "Information" },
    underline = { min  = "Warning" },
})

vim.lsp.config('luals', {
  on_attach = function()
    print('LSP: luals is now active in this file.')
  end,
})

vim.lsp.config('angularls', {
  on_attach = function()
    print('LSP: angularls is now active in this file.')
  end,
})

vim.lsp.config('tsls', {
  on_attach = function()
    print('LSP: tsls is now active in this file.')
  end,
})

vim.lsp.config('csls', {
  on_attach = function()
    print('LSP: csls is now active in this file.')
  end,
})

vim.lsp.config('eslintls', {
  on_attach = function()
    print('LSP: eslintls is now active in this file.')
  end,
})

-- Enabled LSP(s)
vim.lsp.enable('luals')
vim.lsp.enable('angularls');
vim.lsp.enable('tsls');
vim.lsp.enable('csls');
vim.lsp.enable('eslintls');

-- Completion
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client ~= nil and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end
  end,
})

-- Inlay Hints - Enable Code lens
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--
--     if client ~= nil and client:supports_method('textDocument/inlayHint') then
--       vim.lsp.inlay_hint.enable(true, {bufnr = args.buf})
--     end
--   end,
-- })

-- Inlay Hints - Disable Code lens
vim.lsp.inlay_hint.enable(false);

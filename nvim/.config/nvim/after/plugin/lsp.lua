local lsp_zero = require('lsp-zero')

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- custom lsp on attach configuration
  -- print(' LSP >>> '  .. tostring(client.name) .. ' ATTACHING')
  if vim.g.custom_lsp_stop == true then
      -- print(' LSP >>> '  .. tostring(client.name) .. ' SKIPPED')
      vim.cmd.LspStop(client.name)
      return
  end

  if client.name == "omnisharp" then
      client.server_capabilities.semanticTokensProvider = {
          full = vim.empty_dict(),
          legend = {
              tokenModifiers = { "static_symbol" },
              tokenTypes = {
                  "comment",
                  "excluded_code",
                  "identifier",
                  "keyword",
                  "keyword_control",
                  "number",
                  "operator",
                  "operator_overloaded",
                  "preprocessor_keyword",
                  "string",
                  "whitespace",
                  "text",
                  "static_symbol",
                  "preprocessor_text",
                  "punctuation",
                  "string_verbatim",
                  "string_escape_character",
                  "class_name",
                  "delegate_name",
                  "enum_name",
                  "interface_name",
                  "module_name",
                  "struct_name",
                  "type_parameter_name",
                  "field_name",
                  "enum_member_name",
                  "constant_name",
                  "local_name",
                  "parameter_name",
                  "method_name",
                  "extension_method_name",
                  "property_name",
                  "event_name",
                  "namespace_name",
                  "label_name",
                  "xml_doc_comment_attribute_name",
                  "xml_doc_comment_attribute_quotes",
                  "xml_doc_comment_attribute_value",
                  "xml_doc_comment_cdata_section",
                  "xml_doc_comment_comment",
                  "xml_doc_comment_delimiter",
                  "xml_doc_comment_entity_reference",
                  "xml_doc_comment_name",
                  "xml_doc_comment_processing_instruction",
                  "xml_doc_comment_text",
                  "xml_literal_attribute_name",
                  "xml_literal_attribute_quotes",
                  "xml_literal_attribute_value",
                  "xml_literal_cdata_section",
                  "xml_literal_comment",
                  "xml_literal_delimiter",
                  "xml_literal_embedded_expression",
                  "xml_literal_entity_reference",
                  "xml_literal_name",
                  "xml_literal_processing_instruction",
                  "xml_literal_text",
                  "regex_comment",
                  "regex_character_class",
                  "regex_anchor",
                  "regex_quantifier",
                  "regex_grouping",
                  "regex_alternation",
                  "regex_text",
                  "regex_self_escaped_character",
                  "regex_other_escape",
              },
          },
          range = true,
      }
  end

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- print(' LSP >>> '  .. tostring(client.name) .. ' LOADED')
end)

-- no longer available? 'tsserver',

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'omnisharp',
    'terraformls',
    'bashls',
    'vimls',
    'angularls',
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    eslint = function()
      require('lspconfig').eslint.setup({
        filetypes = { 'typescript', 'html' },
        root_dir = require('lspconfig/util').root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json'),
        settings = {
            workingDirectory = { mode = 'auto' },
            rules = {
                ["@angular-eslint/template/no-any"] = "off",
                ["@angular-eslint/template/use-track-by-function"] = "off"
            },
        },
        on_new_config = function(config, new_root_dir)
            -- print(' LSP ESLINT WS >>> '  .. tostring(config.settings.workspaceFolder))
            config.settings.workspaceFolder = {
                uri = vim.uri_from_fname(new_root_dir),
                name = vim.fn.fnamemodify(new_root_dir, ':t')
            }
            -- print(' LSP ESLINT WS SET >>> '  .. tostring(config.settings.workspaceFolder))
        end,
        -- on_attach = function(client, bufnr)
        --   vim.api.nvim_create_autocmd("BufWritePre", {
        --     buffer = bufnr,
        --     command = "EslintFixAll",
        --   })
        -- end,
      })
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  }),
})

vim.diagnostic.config({
    virtual_text = true
})

local function custom_eslint_on_publish_diagnostics(_, result, ctx, config)
    if result.diagnostics then
        local filtered_diagnostics = {}
        local ignore_codes = { -9910002 } -- structual directive error

        for _, diagnostic in ipairs(result.diagnostics) do
            if not vim.tbl_contains(ignore_codes, diagnostic.code) then
                table.insert(filtered_diagnostics, diagnostic)
            end
        end

        result.diagnostics = filtered_diagnostics
    end

    vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

-- Severity limit override -- report Error, Warning, Information < Hint -- neovim.lsp.protocol.DiagnosticSeverity
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_eslint_on_publish_diagnostics, {
    virtual_text = { min = "Information" },
    underline = { min  = "Warning" },
})

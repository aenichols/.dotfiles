local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'rust_analyzer',
  'omnisharp',
  -- 'csharp_ls',
  'terraformls',
  'bashls',
  'vimls',
  'angularls',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
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
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

-- Severity limit override -- report Error, Warning, Information < Hint -- neovim.lsp.protocol.DiagnosticSeverity
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { severity_limit = "Information" },
    underline = { severity_limit  = "Warning" }
})

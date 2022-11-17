local Remap = require("rooster.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local sumneko_root_path = vim.fn.expand(vim.env.HOME .. "/.vscode/extensions/sumneko.lua-*/server")
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local function on_cwd()
    return vim.loop.cwd()
end

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    copilot = "[CP]",
    path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == "copilot" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "copilot" },
    },
    -- experimental = {
    --     native_menu = false,
    --     ghost_text = true,
    -- },
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = function()
            nnoremap("gd",          function() vim.lsp.buf.definition() end)
            nnoremap("gi",          function() vim.lsp.buf.implementation() end)
            nnoremap("K",           function() vim.cmd("Lspsaga hover_doc") end) -- vim.lsp.buf.hover()
            nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
            nnoremap("<leader>vd",  function() vim.cmd("Lspsaga show_line_diagnostics") end) -- vim.diagnostic.open_float()
            nnoremap("[d",          function() vim.cmd("Lspsaga diagnostic_jump_next") end) -- vim.diagnostic.goto_next()
            nnoremap("]d",          function() vim.cmd("Lspsaga diagnostic_jump_prev") end) -- vim.diagnostic.goto_prev()
            nnoremap("<leader>vca", function() vim.cmd("Lspsaga code_action") end) -- vim.lsp.buf.code_action()
            nnoremap("<leader>vrr", function() vim.cmd("Lspsaga lsp_finder") end) -- vim.lsp.buf.references()
            nnoremap("<leader>vrn", function() vim.cmd("Lspsaga rename") end) -- vim.lsp.buf.rename()
            nnoremap("<leader>vpd", function() vim.cmd("Lspsaga peek_definition") end)
            inoremap("<C-h>",       function() vim.lsp.buf.signature_help() end)
        end,
    }, _config or {})
end

require("lspconfig").tsserver.setup(config())

--[[  I cannot seem to get this woring on new computer..
require("lspconfig").clangd.setup(config({
    cmd = { "clangd", "--background-index", "--log=verbose" },
    root_dir = on_cwd,
}))
--]]
require("lspconfig").ccls.setup(config())

require("lspconfig").jedi_language_server.setup(config())

require("lspconfig").svelte.setup(config())

require("lspconfig").solang.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").gopls.setup(config({
    cmd = { "gopls", "serve" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}))

-- who even uses this?
require("lspconfig").rust_analyzer.setup(config({
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    --[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}))

require("lspconfig").sumneko_lua.setup(config({
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}))

--angularls
local probeLoc  = vim.env.HOME .. "/AppData/Roaming/npm/node_modules"
local angularCmd = { "ngserver.cmd", "--stdio", "--tsProbeLocations", probeLoc , "--ngProbeLocations", probeLoc }
require"lspconfig".angularls.setup(config({
    cmd = angularCmd,
    filetypes = { "html" },
    root_dir = on_cwd,
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = angularCmd
        new_config.root_dir = on_cwd
    end,
}))

--OmniSharp
-- local pid = vim.fn.getpid()
-- local omnisharp_bin = "omnisharp"
-- require'lspconfig'.omnisharp.setup{
--     cmd = { omnisharp_bin, "-l", "Debug", "-v", "Debug", "--languageserver" , "--hostPID", tostring(pid) };
-- }
-- local util = require("lspconfig/util")
-- local  function on_root()
--     local fname = on_cwd()
--     local found_root = util.root_pattern("*.sln", "*.csproj", ".git")(fname) or util.path.dirname(fname)
--     return found_root
-- end

local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_exe = "C:/OmniSharp/OmniSharp.exe"
-- local omnisharp_exe_vscode  = vim.fn.expand(vim.env.HOME .. "/.vscode/extensions/ms-dotnettools.csharp-*/.omnisharp/*/OmniSharp.exe")
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require"lspconfig".omnisharp.setup(config({
  handlers = { ["textDocument/definition"] = require('omnisharp_extended').handler, },
  root_dir = on_cwd,
  cmd = { omnisharp_exe, "--languageserver" , "--hostPID", tostring(pid) },
  ...
}))

--csharp_ls
--dotnet tool install --global csharp-ls
-- require"lspconfig".csharp_ls.setup(config({
--     root_dir = on_cwd,
-- }))

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
    local plugins = { "friendly-snippets" }
    local paths = {}
    local path
    local root_path = vim.env.HOME .. "/.vim/plugged/"
    for _, plug in ipairs(plugins) do
        path = root_path .. plug
        if vim.fn.isdirectory(path) ~= 0 then
            table.insert(paths, path)
        end
    end
    return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {},
})

-- Severity limit override -- report Error, Warning, Information < Hint -- neovim.lsp.protocol.DiagnosticSeverity
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { severity_limit = "Information" },
    underline = { severity_limit  = "Warning" },
})

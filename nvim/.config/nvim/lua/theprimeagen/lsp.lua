local sumneko_root_path = vim.fn.expand(vim.env.HOME .. "/.vscode/extensions/sumneko.lua-*/server")
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local function on_cwd()
    return vim.loop.cwd()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
    nvim_lsp = "[LSP]",
    buffer = "[Buffer]",
    nvim_lua = "[Lua]",
    path = "[Path]",
    copilot = "[CP]",
}
local lspkind = require("lspkind")
-- require("lspkind").init({
--     mode = 'symbol_text',
-- })

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
    },
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
        end
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "copilot" },
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
            Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
            Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
            Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
            Nnoremap("[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
            Nnoremap("]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
            Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
            Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
            Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
            Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
        end,
    }, _config or {})
end

--ts
require"lspconfig".tsserver.setup(config({ root_dir = on_cwd }))

--cpp
require"lspconfig".clangd.setup(config({ root_dir = on_cwd }))

--lua
require"lspconfig".sumneko_lua.setup(config({
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
    root_dir = on_cwd;
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"},
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
--
-- local pid = vim.fn.getpid()
-- -- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
-- local omnisharp_exe = "C:/OmniSharp/OmniSharp.exe"
-- local omnisharp_exe_vscode  = vim.fn.expand(vim.env.HOME .. "/.vscode/extensions/ms-dotnettools.csharp-*/.omnisharp/*/OmniSharp.exe")
-- -- on Windows
-- -- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
-- require"lspconfig".omnisharp.setup(config({
--   root_dir = on_root,
--   cmd = { omnisharp_exe_vscode, "--languageserver" , "--hostPID", tostring(pid) },
--   ...
-- }))

--csharp_ls
--dotnet tool install --global csharp-ls
-- require"lspconfig".csharp_ls.setup(config({
--     root_dir = on_root,
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
    include = nil,  -- Load all languages
    exclude = {}
})

-- Severity limit override -- report Error, Warning, Information < Hint -- neovim.lsp.protocol.DiagnosticSeverity
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { severity_limit = "Information" },
    underline = { severity_limit  = "Warning" },
})

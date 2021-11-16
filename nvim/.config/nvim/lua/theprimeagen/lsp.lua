local util = require("lspconfig/util")

local sumneko_root_path = vim.env.HOME .. '/.vscode/extensions/sumneko.lua-2.4.7/server'
local sumneko_binary = sumneko_root_path .. "/bin/Windows/lua-language-server"

local function on_cwd()
  return vim.loop.cwd()
end

local  function on_root()
  local fname = on_cwd()
  local found_root = util.root_pattern("*.sln", "*.csproj", ".git")(fname) or util.path.dirname(fname)
  return found_root
end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = "path" },
        { name = 'buffer' },
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }, _config or {})
end

require'lspconfig'.tsserver.setup(config({
  root_dir = on_cwd
}))

require'lspconfig'.clangd.setup(config({
    root_dir = on_cwd
}))

require'lspconfig'.sumneko_lua.setup(config({
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
    root_dir = on_cwd;
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}))

local probeLoc  = vim.env.HOME .. "/AppData/Roaming/npm/node_modules"
local angularCmd = { "ngserver.cmd", "--stdio", "--tsProbeLocations", probeLoc , "--ngProbeLocations", probeLoc }
require'lspconfig'.angularls.setup(config({
  cmd = angularCmd,
  filetypes = { "html" },
  root_dir = on_cwd,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = angularCmd
    new_config.root_dir = on_cwd
  end,
}))

--OmniSharp
local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "C:/OmniSharp/OmniSharp.exe"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require'lspconfig'.omnisharp.setup(config({
    root_dir = on_root,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
    ...
}))

--csharp_ls
--require'lspconfig'.csharp_ls.setup(config({
--    root_dir = function()
--        local fname = on_cwd()
--        local found_root = util.root_pattern("*.sln", "*.csproj", ".git")(fname) or util.path.dirname(fname)
--        return found_root
--    end
--}))

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

require('symbols-outline').setup(opts)

local snippets_paths = function()
    local plugins = { "friendly-snippets" }
    local paths = {}
    local path
    local root_path = vim.env.HOME .. '/.vim/plugged/'
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


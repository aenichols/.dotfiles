

local sumneko_root_path = 'C:/Users/anthony.nichols/.vscode/extensions/sumneko.lua-1.20.4/server'
local sumneko_binary = sumneko_root_path .. "/bin/Windows/lua-language-server"

local function on_attach()
    -- TODO: TJ told me to do this and I should do it because he is Telescopic
    -- "Big Tech" "Cash Money" Johnson
end

local function on_cwd()
  return vim.loop.cwd()
end

require'lspconfig'.tsserver.setup { on_attach=on_attach }

require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    root_dir = on_cwd
}

require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
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
}

local probeLoc  = 'C:/Users/anthony.nichols/.vscode/extensions/angular.ng-template-11.2.11/node_modules'
local angularCmd = { "ngserver.cmd", "--stdio", "--tsProbeLocations", probeLoc , "--ngProbeLocations", probeLoc }
require'lspconfig'.angularls.setup {
  on_attach = on_attach,
  cmd = angularCmd,
  root_dir = on_cwd,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = angularCmd
    new_config.root_dir = on_cwd
  end,
}

local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "C:/OmniSharp/OmniSharp.exe"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require'lspconfig'.omnisharp.setup {
    on_attach = on_attach,
    root_dir = on_cwd,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
    ...
}

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


local cmd = { 'vscode-eslint-language-server', '--stdio' }

local root_file_types = {
    'html',
    'htmlangular',
    'typescript',
}

local root_dir = vim.fn.getcwd()

return {
    cmd = cmd,
    filetypes = root_file_types,
    root_dir = root_dir,
    settings = {
        validate = 'on',
        packageManager = nil,
        useESLintClass = false,
        experimental = {
            useFlatConfig = false,
        },
        codeActionOnSave = {
            enable = false,
            mode = 'all',
        },
        format = true,
        quiet = false,
        onIgnoredFiles = 'off',
        rulesCustomizations = {},
        run = 'onType',
        problems = {
            shortenToSingleLine = false,
        },
        nodePath = '',
        workingDirectory = { mode = 'auto' },
        workspaceFolder = {
            uri = vim.uri_from_fname(root_dir),
            name = vim.fn.fnamemodify(root_dir, ':t')
        },
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = 'separateLine',
            },
            showDocumentation = {
                enable = true,
            },
        },
    },
    on_new_config = function(config, new_root_dir)
        config.cmd = cmd
        config.filetypes = root_file_types
        config.settings.workspaceFolder = {
            uri = vim.uri_from_fname(new_root_dir),
            name = vim.fn.fnamemodify(new_root_dir, ':t'),
        }

        if
            vim.fn.filereadable(new_root_dir .. '/eslint.config.js') == 1
            or vim.fn.filereadable(new_root_dir .. '/eslint.config.mjs') == 1
            or vim.fn.filereadable(new_root_dir .. '/eslint.config.cjs') == 1
            or vim.fn.filereadable(new_root_dir .. '/eslint.config.ts') == 1
            or vim.fn.filereadable(new_root_dir .. '/eslint.config.mts') == 1
            or vim.fn.filereadable(new_root_dir .. '/eslint.config.cts') == 1
        then
            config.settings.experimental.useFlatConfig = true
        end
    end,
    handlers = {
        ['eslint/openDoc'] = function(_, result)
            if result then
                vim.ui.open(result.url)
            end
            return {}
        end,
        ['eslint/confirmESLintExecution'] = function(_, result)
            if not result then
                return
            end
            return 4 -- approved
        end,
        ['eslint/probeFailed'] = function()
            vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
            return {}
        end,
        ['eslint/noLibrary'] = function()
            vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
            return {}
        end,
    },
}

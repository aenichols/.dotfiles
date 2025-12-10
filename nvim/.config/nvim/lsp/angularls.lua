-------
-- FOO angularls.lua configuration for nvim-lspconfig
-------
local function get_my_project_root(root_dir)
    local project_root = root_dir .. '/node_modules'
    return project_root
end

local ts_probe_dir_raw = "~/scoop/persist/nvm/nodejs/v18.20.8/node_modules/typescript/lib"
local ts_probe_dir = vim.fn.expand(ts_probe_dir_raw)

local ng_probe_dir_raw = "~/scoop/persist/nvm/nodejs/v18.20.8/node_modules/@angular/language-server/bin"
local ng_probe_dir = vim.fn.expand(ng_probe_dir_raw)

local root_dir = vim.fn.getcwd()
local project_root = get_my_project_root(root_dir)

local cmd = {
    'ngserver',
    '--stdio',
    '--tsProbeLocations',
    ts_probe_dir,
    '--ngProbeLocations',
    ng_probe_dir,
    '--angularCoreVersion',
    '15.2.6',
    '--logFile', '/tmp/angularls.log',
    '--logVerbosity',
    'verbose',
}

local filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' }

return {
    cmd = cmd,
    hint = { enable = true },
    root_markers = { 'angular.json' },
    filetypes = filetypes,
}


-------
-- Old angularls.lua configuration for nvim-lspconfig
-------
-- local function get_project_root(root_dir)
--     local project_root = vim.fs.dirname(vim.fs.find('angular.json', { path = root_dir, upward = true })[1])
--     return project_root or root_dir
-- end
--
-- local function get_angular_core_version(root_dir)
--     local project_root = get_project_root(root_dir)
--
--     if not project_root then
--         return ''
--     end
--
--     local package_json = project_root .. '/package.json'
--     if not vim.loop.fs_stat(package_json) then
--         return ''
--     end
--
--     local file = io.open(package_json, 'r')
--     if not file then
--         return ''
--     end
--
--     local contents = file:read('*a')
--     file:close()
--
--     local json = vim.json.decode(contents)
--     if not json.dependencies then
--         return ''
--     end
--
--     local angular_core_version = json.dependencies['@angular/core']
--     return angular_core_version or ''
-- end
--
-- local function get_my_project_root(root_dir)
--     local project_root = root_dir .. 'HALLO'
--     return project_root
-- end
--
-- return {
--     cmd = function()
--         -- local project_root = get_project_root(vim.fn.getcwd())
--         -- local angular_core_version = get_angular_core_version(vim.fn.getcwd())
--
--         local project_root = get_my_project_root(vim.fn.getcwd())
--
--         print("HALLO project root: " .. project_root)
--
--         return {
--             'ngserver',
--             '--stdio',
--             '--tsProbeLocations',
--             project_root,
--             '--ngProbeLocations',
--             project_root,
--         }
--     end,
--     hint = { enable = true },
--     root_markers = { 'angular.json' },
--     filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
--     on_new_config = function(new_config, new_root_dir)
--         -- local project_root = get_project_root(new_root_dir)
--         -- local angular_core_version = get_angular_core_version(new_root_dir)
--
--         local project_root = get_my_project_root(vim.fn.getcwd())
--         print("HALLO project root: " .. project_root)
--
--         new_config.cmd = {
--             'ngserver',
--             '--stdio',
--             '--tsProbeLocations',
--             project_root,
--             '--ngProbeLocations',
--             project_root,
--         }
--     end,
-- }

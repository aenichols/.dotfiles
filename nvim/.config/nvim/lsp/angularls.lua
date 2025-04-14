local function get_probe_dir(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find('node_modules', { path = root_dir, upward = true })[1])

    return project_root and (project_root .. '/node_modules') or ''
end

local function get_probe_dirts(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find('node_modules', { path = root_dir, upward = true })[1])

    return project_root and (project_root .. '/node_modules/typescript/lib') or ''
end

local function get_probe_dirls(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find('node_modules/', { path = root_dir, upward = true })[1])

    return project_root and (project_root .. '/node_modules/@angular/language-service') or ''
end

local function get_angular_core_version(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find('node_modules', { path = root_dir, upward = true })[1])

    if not project_root then
        return ''
    end

    local package_json = project_root .. '/package.json'
    if not vim.loop.fs_stat(package_json) then
        return ''
    end

    local contents = io.open(package_json):read '*a'
    local json = vim.json.decode(contents)
    if not json.dependencies then
        return ''
    end

    local angular_core_version = json.dependencies['@angular/core']

    return angular_core_version
end

local default_probe_dir = get_probe_dir(vim.fn.getcwd())
local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())
local default_probe_dirts = get_probe_dirts(vim.fn.getcwd())
local default_probe_dirls = get_probe_dirls(vim.fn.getcwd())

local cmd = {
    'ngserver',
    '--stdio',
    '--tsProbeLocations',
    default_probe_dirts,
    '--ngProbeLocations',
    default_probe_dirls,
    '--angularCoreVersion',
    default_angular_core_version
}

return {
    cmd = cmd,
    hint = { enable = true },
    root_markers = { 'angular.json' },
    filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = cmd
    end,
}

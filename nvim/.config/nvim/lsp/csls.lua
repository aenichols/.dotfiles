local cmd = {
    'csharp-ls',
    '--loglevel',
    'warning',
}

return {
    cmd = cmd,
    root_markers = {'.git'},
    filetypes = { 'cs' },
    handlers = {
        ["window/showMessage"] = function(_, result, ctx)
            -- Don't show these messages in a way that requires input
            vim.notify(result.message, vim.log.levels.INFO)
            return nil
        end,
    },
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = cmd
    end,
}

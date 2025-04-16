local cmd = {
    'csharp-ls',
    '--loglevel',
    'warning',
}

return {
    cmd = cmd,
    root_markers = {'.git'},
    filetypes = { 'cs' },
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = cmd
    end,
}

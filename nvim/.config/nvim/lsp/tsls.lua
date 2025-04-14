return {
    cmd = {'typescript-language-server', '--stdio'},
    root_markers = {'tsconfig.json', 'jsconfig.json', 'package.json', '.git'},
    filetypes = {
        'html',
        'javascript',
        'typescript',
        'javascript.jsx',
        'typescript.tsx',
        'javascriptreact',
        'typescriptreact',
    },
}

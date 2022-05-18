local M = {}

function M.random()
    local colors = {
        -- gruvy
        'gruvbox-baby',

        -- zenbones
        'zenwritten',
        --'neobones',
        'rosebones',
        'forestbones',
        --'nordbones',
        'tokyobones',
        'seoulbones',
        'duckbones',
        --'zenburned',
        --'kanagawabones',

        -- atelier
        'atelier_lakesidedark',
        'atelier_cavedark',
        'atelier_dunedark',
        'atelier_savannadark',
        'atelier_heathdark',
        'atelier_plateaudark',
        'atelier_forestdark',
        'atelier_estuarydark',

        -- other
        'space-vim-dark',
        'spacemacs-theme',
    }
    local color = colors[math.random(#colors)]
    vim.g['theprimeagen_colorscheme'] = color
end

function M.setup()
    M.random()
end

return M

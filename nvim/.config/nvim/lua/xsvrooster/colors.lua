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
    math.randomseed(os.time())
    local cn = #colors
    local rn = math.random() and math.random() and math.random() and math.random(cn)
    local color = colors[rn]
    vim.g['theprimeagen_colorscheme'] = color
end

function M.setup()
    M.random()
end

return M

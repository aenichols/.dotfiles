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

function M.colorMyPencils()
    M.setup()

    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.g.gruvbox_invert_selection = '0'
    vim.opt.background = "dark"

    vim.cmd("colorscheme " .. vim.g.theprimeagen_colorscheme)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("SignColumn", {
        bg = "none",
    })

    -- hl("ColorColumn", {
    --     ctermbg = 0,
    --     bg = "#555555",
    -- })

    hl("CursorLineNR", {
        bg = "None"
    })

    -- hl("Normal", {
    --     bg = "none"
    -- })

    -- hl("LineNr", {
    --     fg = "#5eacd3"
    -- })

    hl("netrwDir", {
        fg = "#5eacd3"
    })

    hl("Folded", {
        bg = "none"
    })

    hl("FoldColumn", {
        bg = "none"
    })

    hl("CocHintHighlight", {
        bg = "none"
    })
end

return M

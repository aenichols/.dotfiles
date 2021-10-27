local M = {}

local function load_highlights(ns, highlights)
    local get_namespace = vim.api.nvim_get_namespaces
    local nsValue = get_namespace()[ns]

    local highlight = vim.api.nvim_set_hl

    for group_name, group_settings in pairs(highlights) do
        highlight(nsValue, group_name, group_settings)
    end
end

local function load_tokyo_hightlights(cs)
    if cs ~= 'tokyodark' then
      return
    end

    local ns = 'tokyodark'
    require(cs)

    local hl = { langs = {}, plugins = {} }

    local p = require(ns ..'.palette')
    hl.overrides = {
      Visual = { bg = '#ffffff', fg = p.black },
      CursorColumn = { bg = '#404040' },
    }

    --Tokyo Dark
    vim.g.tokyodark_transparent_background = 1
    vim.g.tokyodark_enable_italic_comment = 1
    vim.g.tokyodark_enable_italic = 1
    vim.g.tokyodark_color_gamma = "1.0"
    --load_highlights(ns, hl.overrides)
end

function M.setup()
    vim.g['theprimeagen_colorscheme'] = "gruvbox"
    --vim.g['theprimeagen_colorscheme'] = "tokyodark"
    local cs = vim.g.theprimeagen_colorscheme

    load_tokyo_hightlights(cs)
end

return M

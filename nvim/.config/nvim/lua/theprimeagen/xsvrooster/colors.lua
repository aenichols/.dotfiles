local ns = 'tokyodark'

require(ns)
local p = require(ns ..'.palette')
local M = {}
local highlight = vim.api.nvim_set_hl
local get_namespace = vim.api.nvim_get_namespaces
local nsValue = get_namespace()[ns]
local hl = {langs = {}, plugins = {}}

hl.overrides = {
  Visual = {bg = '#ffffff', fg = p.black },
}

local function load_highlights(ns, highlights)
    for group_name, group_settings in pairs(highlights) do
        highlight(nsValue, group_name, group_settings)
    end
end

local function load_tokyo_hightlights()

    load_highlights(ns, hl.overrides)
end

function M.setup()

    load_tokyo_hightlights()
end

return M

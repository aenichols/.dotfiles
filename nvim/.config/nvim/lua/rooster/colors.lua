local gruvbox = "gruvbox"
local rosepine = "rose-pine"
local tokyonight = "tokyonight"
local tokyonightstorm = "tokyonight-storm"

function ColorMyPencils(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)

    if color == gruvbox then
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    elseif color == tokyonightstorm or color == tokyonight then
        vim.api.nvim_set_hl(0, "Normal", { bg = "#1F2335" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1F2335" })
    end

    -- Defaults
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555" })
end

function ColorMe()
    local cwd = vim.fn.getcwd()

    if cwd:find("%ConnectBooster") then
        ColorMyPencils(gruvbox)
    elseif cwd:find("%QuickerPay") then
        ColorMyPencils(tokyonightstorm)
    else
        ColorMyPencils(rosepine)
    end
end

return {
    gruvbox,
    rosepine,
    tokyonight,
    tokyonightstorm,
    ColorMyPencils
}

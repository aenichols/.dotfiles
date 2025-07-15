local harpy = "harpy"
local noir = "noirbuddy"
local gruvbox = "gruvbox"
local rosepine = "rose-pine"
local prime = "rose-pine-moon"
local tokyonight = "tokyonight"
local tokyonightstorm = "tokyonight-storm"

function ColorMyPencils(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)

    if color == gruvbox then
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#302D2B" })
    elseif color == tokyonightstorm or color == tokyonight then
        vim.api.nvim_set_hl(0, "Normal", { bg = "#1F2335" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1F2335" })
    elseif color == rosepine or color == prime or color == harpy then
        vim.api.nvim_set_hl(0, "Normal", { bg = "#24181A" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "#20181A" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
    elseif color == noir then
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "#24181A" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#20181A" })
    end

    -- Defaults
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555" })
end

function ColorMe()
    local cwd = vim.fn.getcwd()

    if cwd:find("%ConnectBooster") then
        ColorMyPencils(prime)
    elseif cwd:find("%QuickerPay") then
        ColorMyPencils(tokyonightstorm)
    else
        ColorMyPencils(rosepine)
    end
end

return {
    noir,
    harpy,
    prime,
    gruvbox,
    rosepine,
    tokyonight,
    ColorMyPencils,
    tokyonightstorm
}

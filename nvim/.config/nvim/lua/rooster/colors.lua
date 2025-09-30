local harpy = "harpy"
local noir = "noirbuddy"
local gruvbox = "gruvbox"
local rosepine = "rose-pine"
local prime = "rose-pine-moon"
local tokyonight = "tokyonight"
local tokyonightstorm = "tokyonight-storm"

function ColorMyPencils(color)
    color = color or "gruvbox"
    local floatBackground = "#1F2335"

    vim.cmd.colorscheme(color)

    if color == gruvbox then

        floatBackground = "#302D2B"
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = floatBackground })

    elseif color == tokyonightstorm or color == tokyonight then

        floatBackground = "#20181A"
        vim.api.nvim_set_hl(0, "Normal", { bg = "#1F2335" })

    elseif color == rosepine or color == prime or color == harpy then

        floatBackground = "#1F2335"
        vim.api.nvim_set_hl(0, "Normal", { bg = "#24181A" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "#20181A" })

    elseif color == noir then
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "#24181A" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#20181A" })
    end

    -- Defaults
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = floatBackground })

    vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#29A4BD", bg = floatBackground })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#29A4BD", bg = floatBackground })

    vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#C0CAF5", bg = floatBackground })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#29A4BD", bg = floatBackground })

    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#FF9E64", bg = floatBackground })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#FF9E64", bg = floatBackground })

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

function ColorMyPencils(color)
    color = color or "gruvbox-baby"

    vim.g.gruvbox_baby_transparent_mode = true

    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

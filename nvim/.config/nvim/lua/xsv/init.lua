local augroup = vim.api.nvim_create_augroup
XSVGroup = augroup('XSV', {})
local autocmd = vim.api.nvim_create_autocmd

-- 89Pace
local eightyninepace = require("xsv.89pace.prog")
eightyninepace.setup()

-- Comment
require("Comment").setup()

-- TrueZen
require("xsv.truezen")

-- Language
require("xsv.language")

-- VisualWhitespace
require("xsv.visual-whitespace")

-- Overrides
require("xsv.set")

autocmd({"BufWinEnter", "BufRead", "BufNewFile"}, {
    group = XSVGroup,
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove("o")
    end
})


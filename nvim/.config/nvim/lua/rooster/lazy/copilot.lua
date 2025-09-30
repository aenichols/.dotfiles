vim.g.copilot_node_command = vim.fn.expand([[~\scoop\apps\nvm\current\nodejs\v22.19.0\node.exe]])

return {
  "github/copilot.vim",
  config = function()
    require("copilot").setup({})
  end,
}

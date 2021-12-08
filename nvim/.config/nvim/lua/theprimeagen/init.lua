require("theprimeagen.xsvrooster.telescope")
local eightyninepace = require("theprimeagen.xsvrooster.89pace.prog")
local colors = require("theprimeagen.xsvrooster.colors")

require("theprimeagen.telescope")
require("theprimeagen.debugger")
require("theprimeagen.harpoon")
require("theprimeagen.lsp")

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

colors.setup()
eightyninepace.setup()

require("Comment").setup()

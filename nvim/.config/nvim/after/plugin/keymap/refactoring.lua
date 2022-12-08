local Remap = require("rooster.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap("<leader>ri", function()
    require("refactoring").refactor("Inline Variable")
end);

vnoremap("<leader>re", function()
    require("refactoring").refactor("Extract Variable")
end);

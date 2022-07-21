local minimal = require("rooster.minimal")
local Remap = require("rooster.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
local nmap = Remap.nmap

local silent = { silent = true }

nnoremap("<leader>pv", ":Ex<CR>")
nnoremap("<leader>u", ":UndotreeShow<CR>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("Y", "yg$")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- greatest remap ever
xnoremap("<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

vnoremap("<leader>d", "\"_d")

-- This is going to get me cancelled
inoremap("<C-c>", "<Esc>")

nnoremap("Q", "<nop>")
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", silent)

-- ############################################################################
-- #ROOSTER                                                                   #
-- ############################################################################

-- May remove
nnoremap("<leader>h", "<cmd>wincmd h<CR>")
nnoremap("<leader>j", "<cmd>wincmd j<CR>")
nnoremap("<leader>k", "<cmd>wincmd k<CR>")
nnoremap("<leader>l", "<cmd>wincmd l<CR>")

-- Maps Ctrl-[Arrows] to resizing a window split
nmap("<C-M-h>", "<C-w><", { silent = true })
nmap("<C-M-j>", "<C-W>-", { silent = true })
nmap("<C-M-k>", "<C-W>+", { silent = true })
nmap("<C-M-l>", "<C-w>>", { silent = true })

nmap("S", "ddO")
nmap("cc", "S")

--Close buffer
nnoremap("<Leader>q", ":bd<CR>")
nnoremap("<Leader>qa", ":bufdo bd<CR>")

nmap("<MiddleMouse>", "<Nop>")
inoremap("<MiddleMouse>", "<Nop>")

-- Vim Setup Splits
nmap("<leader>vss" ,":wincmd o<CR>:enew<CR>:G<CR>:wincmd j<CR>:wincmd v<CR>:wincmd H<CR>:wincmd l<CR>:wincmd v<CR>10<C-W>-:wincmd l<CR>:lua require(\"harpoon.term\").gotoTerminal(1)<CR>abash<CR><C-\\><C-n>:wincmd j<CR>")

-- ColorMyPencils
nnoremap("<leader>cmp", function()
    require("xsv.colors").colorMyPencils()
end)

-- Log Line
nnoremap("<Leader>ee", "oSystem.Console.WriteLine($\"HALLO {System.Text.Json.JsonSerializer.Serialize()}\");<esc>hhhhi")

-- Float Terminal
nnoremap("<C-f>", "<cmd>lua require('lspsaga.floaterm').open_float_terminal('bash -c \"$DOTFILES/bin/.local/bin/tmux-cht.sh\"')<CR>", silent)
tnoremap("<C-f>", "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", silent)

-- Minimal
nnoremap("<leader>ao", minimal.turn_on_guides)
nnoremap("<leader>ae", minimal.turn_off_guides)


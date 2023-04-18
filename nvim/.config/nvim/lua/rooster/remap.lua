
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- ADDITIONAL #################################################################
-- May remove
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<CR>")

-- Maps Ctrl-[Arrows] to resizing a window split
vim.keymap.set("n", "<C-M-h>", "<C-w><")
vim.keymap.set("n", "<C-M-j>", "<C-W>-")
vim.keymap.set("n", "<C-M-k>", "<C-W>+")
vim.keymap.set("n", "<C-M-l>", "<C-w>>")

vim.keymap.set("n", "S", "ddO")
vim.keymap.set("n", "cc", "S")

--Close buffer
vim.keymap.set("n", "<Leader>q", ":bd<CR>")
vim.keymap.set("n", "<Leader>qa", ":bufdo bd<CR>")

vim.keymap.set({"n", "i"},"<MiddleMouse>", "<Nop>")

-- Log Line
vim.keymap.set("n", "<Leader>ee", "oSystem.Console.WriteLine($\"HALLO {System.Text.Json.JsonSerializer.Serialize()}\");<esc>hhhhi")

-- Float Terminal
vim.keymap.set("n", "<C-f>", "<cmd>TermExec cmd=\"$SCRIPTS/tmux-cht.sh\"<CR>", { silent = true })
vim.keymap.set("n", "<Leader>lg", "<cmd>TermExec cmd=\"lazygit\"<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ft", "<cmd>ToggleTerm<CR>", { silent = true })

-- Minimal
-- vim.keymap.set("<leader>ao", minimal.turn_on_guides)
-- vim.keymap.set("<leader>ae", minimal.turn_off_guides)

-- Maximizer
vim.keymap.set("n", "<leader>m", "<cmd>MaximizerToggle<CR>")


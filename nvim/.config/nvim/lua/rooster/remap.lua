vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- this is going to get me cancelled
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

-- additional #################################################################
-- maps navigating between splits to <leader>h/j/k/l
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<CR>")

-- maps ctrl-[arrows] to resizing a window split
vim.keymap.set("n", "<C-M-h>", "<C-w><")
vim.keymap.set("n", "<C-M-j>", "<C-W>-")
vim.keymap.set("n", "<C-M-k>", "<C-W>+")
vim.keymap.set("n", "<C-M-l>", "<C-w>>")

vim.keymap.set("n", "S", "ddO")
vim.keymap.set("n", "cc", "S")

-- close buffer
vim.keymap.set("n", "<Leader>q", ":bd<CR>")
vim.keymap.set("n", "<Leader>qa", ":bufdo bd<CR>")

vim.keymap.set({"n", "i"},"<MiddleMouse>", "<Nop>")

-- log line
vim.keymap.set("n", "<Leader>ee", "oSystem.Console.WriteLine($\"HALLO {System.Text.Json.JsonSerializer.Serialize()}\");<esc>hhhhi")

-- float terminal
vim.keymap.set("n", "<C-f>", "<cmd>TermExec cmd=\"$SCRIPTS/tmux-cht.sh\"<CR>", { silent = true })
vim.keymap.set("n", "<Leader>lg", "<cmd>TermExec cmd=\"lazygit\"<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ft", "<cmd>ToggleTerm<CR>", { silent = true })

-- maximizer
vim.keymap.set("n", "<leader>m", "<cmd>MaximizerToggle<CR>")

-- fresh start
vim.keymap.set("n", "<leader>fs", ":%bd<CR>:G<CR>:wincmd j<CR>:vsplit<CR>:wincmd h<CR>:vert res -102<CR>:res 60<CR>:wincmd k<CR>:vsplit<CR>:bnext<CR>:wincmd h<CR>:vert res -102<CR>:wincmd j<CR>:wincmd l<CR>")

-- toggle lsp virtual lines
vim.keymap.set('n', '<leader>lvl', function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- toggle lsp virtual text
vim.keymap.set('n', '<leader>lvt', function()
    local new_config = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = new_config })
end, { desc = 'Toggle diagnostic virtual_text' })

-- sort lines - go sort
vim.keymap.set("v", "gs", ":'<,'>! awk '{ print length(), $0 }' | sort -n | cut -d' ' -f2-<CR>", { silent = true })

-- copy current file path to clipboard
vim.keymap.set("n", "<leader>cf", ":let @* = expand('%:.')<CR>", { silent = true })

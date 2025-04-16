return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.8",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        ---@diagnostic disable-next-line: different-requires
        local rooster = require("rooster.telescope")

-- PRIME TIME BEGIN
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>pw", function()
            builtin.grep_string { search = vim.fn.expand("<cword>") }
        end)
        vim.keymap.set("n", "<leader>pW", function()
            builtin.grep_string { search = vim.fn.expand("<cWORD>") }
        end)
-- PRIME TIME END


-- RANCH TIME BEGIN
        vim.keymap.set("n", "<leader>pb", function()
            builtin.buffers()
        end)
        vim.keymap.set("n", "<leader>vrc", function()
            rooster.search_dotfiles()
        end)
        vim.keymap.set("n", "<leader>gc", function()
            rooster.git_branches()
        end)
        vim.keymap.set("n", "<leader>glc", function()
            rooster.git_local_branches()
        end)
        vim.keymap.set("n", "<leader>vpp", function()
            rooster.search_private_proxy()
        end)
        vim.keymap.set("n", "<leader>vcr", function()
            rooster.search_curl_requests()
        end)
-- RANCH TIME END
    end
}

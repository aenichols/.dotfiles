require("telescope.pickers")
require("telescope.finders")
require("telescope.previewers")
require("telescope.actions.state")
require("telescope.config")

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        keep_last_buf = true,
        file_previewer   = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer   = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
            i = {
                ["<C-q>"] = actions.send_to_qflist,
                ["<M-w>"] = actions.delete_buffer,
            },
            n = {
                ["<M-w>"] = actions.delete_buffer,
            }
        },
        preview = { check_mime_type = false },
        --use_unix_friendly_paths = true,
        path_display = function(_, path)
            return path:gsub("\\", "/")
        end,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

require("telescope").load_extension("fzy_native")

local dotfiles_nvim = vim.env.DOTFILES .. "/nvim/.config/nvim"
local M = {}

function M.reload_modules()
	-- Because TJ gave it to me.  Makes me happpy.  Put it next to his other
	-- awesome things.
	local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
	for _, dir in ipairs(lua_dirs) do
		dir = string.gsub(dir, "./lua/", "")
		require("plenary.reload").reload_module(dir)
	end
end

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = dotfiles_nvim,
    })
end

local function set_background(content)
	vim.fn.system("dconf write /org/mate/desktop/background/picture-filename \"'" .. content .. "'\"")
end

local function select_background(prompt_bufnr, map)
    local function set_the_background(close)
        local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
        set_background(content.cwd .. "/" .. content.value)
        if close then
            require("telescope.actions").close(prompt_bufnr)
        end
    end
    map("i", "<C-p>", function()
        set_the_background()
    end)
    map("i", "<CR>", function()
        set_the_background(true)
    end)
end

local function image_selector(prompt, cwd)
    return function()
        require("telescope.builtin").find_files({
            prompt_title = prompt,
            cwd = cwd,

            attach_mappings = function(prompt_bufnr, map)
                select_background(prompt_bufnr, map)
                -- Please continue mapping (attaching additional key maps):
                -- Ctrl+n/p to move up and down the list.
                return true
            end,
        })
    end
end

M.anime_selector = image_selector("< Animoos > ", vim.env.HOME .. "/personal/rooster/animoos/")

local function refactor(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
    require("telescope.actions").close(prompt_bufnr)
    require("refactoring").refactor(content.value)
end

M.refactors = function()
    require("telescope.pickers").new({}, {
        prompt_title = "refactors",
        finder = require("telescope.finders").new_table({
            results = require("refactoring").get_refactors(),
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", refactor)
            map("n", "<CR>", refactor)
            return true
        end,
    }):find()
end

--##############################################################################
--#ROOSTER                                                                    #
--##############################################################################
M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            map('i', '<c-u>', actions.git_upstream)
            map('n', '<c-u>', actions.git_upstream)
            return true
        end,
    })

end

M.git_local_branches = require("xsvrooster.telescope").git_local_branches;
M.search_private_proxy  = require("xsvrooster.telescope").search_private_proxy;
M.search_curl_requests  = require("xsvrooster.telescope").search_curl_requests;

return M


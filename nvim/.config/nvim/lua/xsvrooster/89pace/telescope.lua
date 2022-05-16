local C = require("xsvrooster.89pace.config")
local S = C.session

local M = {}

local function get_activity_table()
    if S.activity_types == nil then
        return {}
    end
    local list = {}
    for i, activity in ipairs(S.activity_types) do
        table.insert(list, i .. " " .. activity.name)
    end
    return list
end

local function handle_activity_selection()
    vim.api.
end

M.activities  = function()
    require("telescope.pickers").new({}, {
        prompt_title = "Picante Activities",
        finder = require("telescope.finders").new_table({
            results = get_activity_table(),
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", print("HALLO Picante Activities"))
            map("n", "<CR>", print("HALLO Picante Activities"))
            return true
        end,
    }):find()
end

return M

        -- attach_mappings = function(_, map)
        --   require  actions.select_default:replace(actions.git_checkout)
        --     map("i", "<c-t>", actions.git_track_branch)
        --     map("n", "<c-t>", actions.git_track_branch)
        --
        --     map("i", "<c-r>", actions.git_rebase_branch)
        --     map("n", "<c-r>", actions.git_rebase_branch)
        --
        --     map("i", "<c-a>", actions.git_create_branch)
        --     map("n", "<c-a>", actions.git_create_branch)
        --
        --     map("i", "<c-s>", actions.git_switch_branch)
        --     map("n", "<c-s>", actions.git_switch_branch)
        --
        --     map("i", "<c-d>", actions.git_delete_branch)
        --     map("n", "<c-d>", actions.git_delete_branch)
        --
        --     map("i", "<c-y>", actions.git_merge_branch)
        --     map("n", "<c-y>", actions.git_merge_branch)
        --     return true
        -- end,

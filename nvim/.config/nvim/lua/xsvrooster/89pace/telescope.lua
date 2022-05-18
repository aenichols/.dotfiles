local P = require("xsvrooster.89pace.pacer")
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

local function handle_activity_selection(selection)
    if  selection == nil then
        return
    end
    vim.ui.input("Selected [" .. selection .. "], Please enter a work item id: ", function(value)
        if value == nil then
            return
        end
        -- parse out idx # activity_desc
        local idx, _ = string.match(selection, "(%d+)%s+(.+)")
        -- convert to number
        idx = tonumber(idx)
        -- start pacer by selection
        P.start({ tfsId = value, activity_idx = idx })
    end)
end

local function on_selection(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    handle_activity_selection(content.value)
end

M.activities = function()
    local opts = require("telescope.themes").get_cursor()

    require("telescope.pickers").new({}, {
        prompt_title = "Picante Activities",
        finder = require("telescope.finders").new_table({
            results = get_activity_table(),
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(_, map)
            map("i", "<CR>", on_selection)
            map("n", "<CR>", on_selection)
            return true
        end,
    }):find()
end

return M

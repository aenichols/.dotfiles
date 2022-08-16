local P = require("xsv.89pace.pacer")
local C = require("xsv.89pace.config")
local S = C.session
local opts = require("telescope.themes").get_cursor()

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

local function get_workitem_table()
    local work_items = P.get_devops_items()
    local results = {}
    local parse_wi = function(work_item)
        table.insert(results, work_item['System.Id'] .. ' => ' .. work_item['System.Title'])
    end

    for _, work_item in ipairs(work_items) do
        parse_wi(work_item)
    end

    return results
end

local function handle_activity_selection(selection)
    if  selection == nil then
        return
    end
    -- parse out idx # activity_desc
    local idx, _ = string.match(selection, "(%d+)%s+(.+)")
    -- convert to number
    idx = tonumber(idx)

    local function on_workitem_selection(prompt_bufnr)
        local content = require("telescope.actions.state").get_selected_entry(
            prompt_bufnr
        )
        require("telescope.actions").close(prompt_bufnr)

        -- parse out idx # activity_desc
        local id, _ = string.match(content.value, "(%d+)%s+(.+)")
        -- convert to number
        id = tonumber(id)

        P.start({ tfsId = id, activity_idx = idx })
    end

    -- fire off second telescope
    require("telescope.pickers").new({}, {
        prompt_title = "Picante Select Work Item [ " .. selection .. " ]",
        finder = require("telescope.finders").new_table({
            results = get_workitem_table(),
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(_, map)
            map("i", "<CR>", on_workitem_selection)
            map("n", "<CR>", on_workitem_selection)
            return true
        end,
    }):find()
    -- vim.ui.input("Selected [" .. selection .. "], Please enter a work item id: ", function(value)
    --     if value == nil then
    --         return
    --     end
    --     -- start pacer by selection
    --     P.start({ tfsId = value, activity_idx = idx })
    -- end)
end

local function on_activity_selection(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    handle_activity_selection(content.value)
end

M.activities = function()
    require("telescope.pickers").new({}, {
        prompt_title = "Picante Activities",
        finder = require("telescope.finders").new_table({
            results = get_activity_table(),
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(_, map)
            map("i", "<CR>", on_activity_selection)
            map("n", "<CR>", on_activity_selection)
            return true
        end,
    }):find()
end

return M

local C = require("xsvrooster.89pace.config")
local S = C.session
local dates = require("xsvrooster.89pace.dates")
local default_section_x
local airline_has_initialized = false

local M = {}

M.init_airline = function()
    if vim.g.airline_section_x == nil then
        return
    end

    -- save default section x
    -- FIXME: should be a better way to do this
    -- Should be set only when not nil and does not contain Get89PaceStatus
    if string.find(vim.g.airline_section_x, "Get89PaceStatus") then
        -- do nothing
    else
        default_section_x = vim.g.airline_section_x
    end

    if default_section_x == nil then
        return
    end

    if airline_has_initialized == false then
        -- default airline function
        vim.api.nvim_exec(
        [[
            function! Get89PaceStatus() abort
                return luaeval('require("xsvrooster.89pace.pacer").get_status()')
            endfunction
        ]],
        false
        )
        -- set function to airline part
        vim.call("airline#parts#define_function", "89pace", "Get89PaceStatus")
        -- define global variable for creating a section in airline
        -- FIXME: this is technically not needed, but was used for testing. Should be local in the future
        vim.cmd("let g:pace_section_x = airline#section#create_right(['89pace'])")
        airline_has_initialized = true
    end

    -- conditions should be- current viewport, width > 175
    -- this should only happen if laststatus != 3 - global status line
        --vim.call("airline#parts#define_minwidth", "89pace", "175")
    -- FIXME: conditions should be- current viewport only - HOW?
    --vim.call("airline#parts#define_condition", "89pace", "nvim_buf_get_name(0) == expand('%')")

    vim.cmd("let g:airline_section_x = '" .. default_section_x .. '%{airline#util#prepend(" ",0)}' .. vim.g.pace_section_x .. "'")
end

M.run = function()
    M.get_time()
    M.refresh_airline()
    --C.log.debug("[89pace.nvim] status:\n" .. C.session.status)
end

M.refresh_airline = function ()
    if C.airline_enabled ~= true then
        return
    end
    M.init_airline()
    -- build status line
    M.build_status()
    -- update airline
    vim.call("airline#update_statusline")
end

-- Build status line- 89pace> <activityType.name:color> <tfsId> <tfsDescription?> Tracking: <hh.mm.ss:red or green> <stopped-icon or check>
M.build_status = function()
    -- 89pace> <activityType.name:color> <tfsId> <tfsDescription?> Tracking: <hh.mm.ss:red or green> <stopped-icon or check>
    local status_template = "89pace  " .. S.activity_name .. " " .. S.tfs_id .. " Tracking: "
    -- Is not tracking
    if S.trackingState == 1 then
        S.status = status_template .. "00.00.00 "
    -- Is tracking
    elseif S.trackingState == 0 then
        local time_l = os.time(os.date("*t"))
        local time_d = os.difftime(time_l, S.trackStart)
        S.status = status_template .. os.date("%H:%M:%S", time_d) .. " "
    end
end

M.get_activities = function ()
    --print(vim.inspect(S.activity_types))
    for i, activity in ipairs(S.activity_types) do
        print(i, activity.name)
    end
end

M.get_status = function()
    return S.status
end

-- Gets the current time for the currently selected task id.
-- FIXME: 2.1 of the API is deprecated, but still works.
M.get_time = function()
    local opts = {
        method = "get",
        url = C.your_api_root .. "/tracking/client/current/false?" .. C.your_api_param_legacy,
        headers = {
            Authorization = "Bearer " .. C.your_api_token
        },
        dry_run = false,
    }
    local response = C.curl[opts.method](opts)
    --C.log.debug("[89pace.nvim] Request get time preview:\n" .. "curl " .. table.concat(response, " "))
    -- parse current tracking
    local result = vim.fn.json_decode(response.body)
    S.tfs_id = result.track.tfsId
    S.trackingState = result.track.trackingState
    S.trackStart = dates.parse_json_date(result.track.currentTrackStartedDateTime)
    S.activity_id = result.track.activityTypeId
    -- parse for activity setting
    S.activity_types = result.settings.activityType.activityTypes
    for _,v in pairs(result.settings.activityType.activityTypes) do
        if v.id == S.activity_id then
            S.activity_name = v.name
            S.activity_color = v.color
            S.activity_default = v.isDefault
            break
        end
    end
end

-- Starts current time tracking on the currently selected task id.
-- FIXME: 2.1 of the API is deprecated, but still works.
M.start = function(opt)
    -- json request body object
    local request = {
        timeZone = dates.get_timezone_offset_in_minutes(),
        tfsId = S.tfs_id,
        remark = "automagic messaging from me in the past",
        activityTypeId = S.activity_id
    }
    -- set options tfsId override
    if opt ~= nil and opt.tfsId ~= nil then
        request.tfsId = opt.tfsId
    end
    -- set options activity override
    if opt ~= nil and opt.activity_idx ~= nil then
        local newActivityType = S.activity_types[opt.activity_idx];
        if newActivityType ~= nil then
            request.activityTypeId = newActivityType.id
        end
    end
    -- set options remark override
    if opt ~= nil and opt.remark ~= nil then
        request.remark = opt.remark
    end
    -- request options
    local opts = {
        method = "post",
        url = C.your_api_root .. "/tracking/client/startTracking?" .. C.your_api_param_legacy,
        headers = {
            Authorization = "Bearer " .. C.your_api_token,
            Content_Type = "application/json"
        },
        body = vim.fn.json_encode(request),
        dry_run = false,
    }
    -- call
    local _ = C.curl[opts.method](opts)
    --C.log.debug("[89pace.nvim] Request start tracking:\n" .. "curl " .. table.concat(_, " "))
    -- update
    M.run()
end

-- Stops current time tracking.
-- FIXME: 2.1 of the API is deprecated, but still works.
M.stop = function()
    -- request options
    local opts = {
        method = "post",
        url = C.your_api_root .. "/tracking/client/stopTracking/0?" .. C.your_api_param_legacy,
        headers = {
            Authorization = "Bearer " .. C.your_api_token,
            Content_Length = 0
        },
        dry_run = false,
    }
    -- call
    local _ = C.curl[opts.method](opts)
    --C.log.debug("[89pace.nvim] Request stop tracking:\n" .. "curl " .. table.concat(_, " "))
    -- update
    M.run()
end

-- Send current week for approval
local function lweek_approval(date)
    -- Jeanette Haugen
    -- {
    --     "uniqueName": "jeanette.h@bngholdingsinc.com",
    --     "displayName": null,
    --     "vstsId": "80796dff-4389-6a92-8dcd-2dc8bb8c5bcd",
    --     "vstsCollectionId": "80796dff-4389-6a92-8dcd-2dc8bb8c5bcd",
    --     "email": "jeanette.h@bngholdingsinc.com",
    --     "name": "Jeanette Haugen",
    --     "id": "1dd838bf-5ae3-4f6d-beee-6217446f7d75"
    -- }
    -- request options
    local opts = {
        method = "post",
        url = C.your_api_root .. "/rest/timeApproval/week?" .. C.your_api_param_stable,
        body = {
            weekStart = date,
            assignedManagerId = "1dd838bf-5ae3-4f6d-beee-6217446f7d75",
        },
        headers = {
            Authorization = "Bearer " .. C.your_api_token,
        },
        dry_run = false,
    }
    -- call
    local res = C.curl[opts.method](opts)
    print("[ 89pace ] Approve week request sent." .. C.dump(res))
end

M.approve_week = function()
    lweek_approval(dates.get_week_start_date())
end

M.approve_lastweek = function()
    lweek_approval(dates.get_last_week_start_date())
end

return M

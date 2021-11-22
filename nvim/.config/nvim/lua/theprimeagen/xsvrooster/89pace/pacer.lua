local C = require("theprimeagen.xsvrooster.89pace.config")
local S = C.session
local dates = require("theprimeagen.xsvrooster.89pace.dates")

local default_section_x = vim.g.airline_section_x

local M = {}

M.run = function()
  M.get_time()
  M.refreshal()
  --C.log.debug("[89pace.nvim] status:\n" .. C.session.status)
end

M.refreshal = function ()
  M.build_status()
  M.update_status_line()
end

-- Build status line- 89pace> <activityType.name:color> <tfsId> <tfsDescription?> Tracking: <hh.mm.ss:red or green> <stopped-icon or check>
M.build_status = function()
  -- 89pace> <activityType.name:color> <tfsId> <tfsDescription?> Tracking: <hh.mm.ss:red or green> <stopped-icon or check>
  S.status = "89pace  " .. S.activity_name .. " " .. S.tfs_id .. " Tracking: "
  -- Is not tracking
  if S.trackingState == 1 then
    S.status = S.status .. "00.00.00 "
  end
  -- Is tracking
  if S.trackingState == 0 then
    local time_l = os.time(os.date("*t"))
    local time_d = os.difftime(time_l, S.trackStart)
    S.status = S.status .. os.date("%H:%M:%S", time_d) .. " "
  end
end

M.get_activities = function ()
  print(vim.inspect(S.activity_types))
end

M.get_status = function()
  return S.status
end

-- Updates airline with current build status
M.update_status_line = function()
  if C.airline_enabled ~= true then
    return
  end
  vim.api.nvim_exec(
    [[
      function! Get89PaceStatus() abort
        return luaeval('require("theprimeagen.xsvrooster.89pace.pacer").get_status()')
      endfunction
    ]],
    false
  )
  vim.call("airline#parts#define_function", "89pace", "Get89PaceStatus")

  -- conditions should be- current viewport, width > 175
  vim.call("airline#parts#define_minwidth", "89pace", "175")
  -- FIXME: conditions should be- current viewport only - HOW?
  --vim.call("airline#parts#define_condition", "89pace", "nvim_buf_get_name(0) == expand('%')")

  -- FIXME: should be a better way- show me da way
  -- create section
  if default_section_x ~= nil then
    vim.cmd("let g:pace_section_x = airline#section#create_right(['89pace'])")
    vim.cmd("let g:airline_section_x = '" .. default_section_x .. '%{airline#util#prepend(" ",0)}' .. vim.g.pace_section_x .. "'")
    -- update airline
    vim.call("airline#update_statusline")
  else
    default_section_x = vim.g.airline_section_x
  end
end

-- Gets the current time for the currently selected task id.
M.get_time = function()
  local opts = {
    method = "get",
    url = C.your_api_root .. "/tracking/client/current/false?" .. C.your_api_param,
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
M.start = function(opt)
  -- json request body object
  local request = {
    timeZone = dates.get_timezone(),
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
    url = C.your_api_root .. "/tracking/client/startTracking?" .. C.your_api_param,
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
M.stop = function()
  -- request options
  local opts = {
    method = "post",
    url = C.your_api_root .. "/tracking/client/stopTracking/0?" .. C.your_api_param,
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
M.approve_week = function()
end

return M

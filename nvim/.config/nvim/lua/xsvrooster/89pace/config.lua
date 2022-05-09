local M = {}

M.curl = require("plenary.curl")
M.log = require("plenary.log").new({ plugin = "89pace.nvim", level = "debug" })

-- FIXME: this is bad ¯\_(ツ)_/¯ will move to local config file and revoke after initial dev
M.your_api_root = "https://connectbooster.timehub.7pace.com/api"
M.your_api_param_legacy = "api-version=2.1"
M.your_api_param_stable = "api-version=3.1"
M.your_api_token = "tOGlkFZkff9CbbtabwEJM3YSxJsIuaQ31RLeJMeZF9k"

-- 0qVE-p_DBJ_R-kSZbXk7Y4wksNwIgSstkbs8S03gSKE
-- tOGlkFZkff9CbbtabwEJM3YSxJsIuaQ31RLeJMeZF9k

M.airline_enabled = true
M.defern = 1000--15000

local S = {}

S.tfs_id = nil
S.trackingState = nil
S.trackStart = nil
S.activity_id = nil
S.activity_name = nil
S.activity_color = nil
S.activity_default = nil
S.activity_types = nil
S.status = ""

M.session = S

M.setup_commands = function ()
 local ns = 'require("xsvrooster/89pace/pacer")'
 local ts = 'require("xsvrooster/89pace/telescope")'
 vim.cmd('command! Pacer lua ' .. ns .. '.run()')
 vim.cmd('command! PacerA lua ' .. ns .. '.runal()')
 vim.cmd('command! PacerStop lua ' .. ns .. '.stop()')
 vim.cmd('command! PacerStart lua ' .. ns .. '.start()')
 vim.cmd('command! PacerStatus lua ' .. ns .. '.update_status_line()')
 vim.cmd('command! PacerActivities lua ' .. ns .. '.get_activities()')
 vim.cmd('command! PacerTSActivities lua ' .. ts .. '.activities()')
 vim.cmd('command! PacerSendWeekForApproval lua ' .. ns .. '.approve_week()')
 vim.cmd('command! PacerSendLastWeekForApproval lua ' .. ns .. '.approve_lastweek()')
end

M.dump = function (o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

return M

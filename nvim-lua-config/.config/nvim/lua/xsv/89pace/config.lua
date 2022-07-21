local M = {}

M.curl = require('plenary.curl')
M.log = require('plenary.log').new({ plugin = '89pace.nvim', level = 'debug' })

-- FIXME: this is bad ¯\_(ツ)_/¯ will move to local config file and revoke after initial dev
M.your_api_root = 'https://connectbooster.timehub.7pace.com/api'
M.your_api_param_legacy = 'api-version=2.1'
M.your_api_param_stable = 'api-version=3.1'
M.your_api_token = 'tOGlkFZkff9CbbtabwEJM3YSxJsIuaQ31RLeJMeZF9k'

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
S.status = ''

M.session = S

local ns = "require('xsv/89pace/pacer')"
local ts = "require('xsv/89pace/telescope')"

local function pacer_completion()
    return {
        'Start',
        'Stop',
        'List',
        'ApproveWeek',
        'ApproveLastWeek',
        'Refresh',
        'Test',
    }
end

local function pacer_complete(opts)
    if opts == nil then
        return
    end

    if opts.args == nil or opts.args == '' then
        -- 89pace depracated for telescope flow
        --noremap <leader>eps :lua require('xsv.89pace.pacer').start({ tfsId = , activity_idx =  })
        vim.cmd('lua ' .. ts .. '.activities()')
    elseif opts.args == 'Start' then
        vim.cmd('lua ' .. ns .. '.start()')
    elseif opts.args == 'Stop' then
        vim.cmd('lua ' .. ns .. '.stop()')
    elseif opts.args == 'List' then
        vim.cmd('lua ' .. ns .. '.get_activities()')
    elseif opts.args == 'ApproveWeek' then
        vim.cmd('lua ' .. ns .. '.approve_week()')
    elseif opts.args == 'ApproveLastWeek' then
        vim.cmd('lua ' .. ns .. '.approve_lastweek()')
    elseif opts.args == 'Refresh' then
        vim.cmd('lua ' .. ns .. '.run()')
    elseif opts.args == 'Test' then
        vim.cmd('lua ' .. ns .. '.get_devops_items()')
    else
        print('Pacer command [ ' .. opts.args ..' ] not supported')
    end
end

M.setup_commands = function ()
    vim.api.nvim_create_user_command('Pacer', pacer_complete, {
        nargs = '?',
        desc = 'pacer, but I barely know her',
        complete = pacer_completion
    })
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

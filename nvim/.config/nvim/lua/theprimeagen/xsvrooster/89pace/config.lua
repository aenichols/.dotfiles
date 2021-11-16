local M = {}

M.curl = require("plenary.curl")
M.log = require("plenary.log").new({ plugin = "89pace.nvim", level = "debug" })

M.your_api_root = "https://connectbooster.timehub.7pace.com/api"
M.your_api_param = "api-version=2.1"
M.your_api_token = "0qVE-p_DBJ_R-kSZbXk7Y4wksNwIgSstkbs8S03gSKE"
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
 local ns = 'require("theprimeagen/xsvrooster/89pace/pacer")'
 vim.cmd('command! Pacer lua ' .. ns .. '.run()')
 vim.cmd('command! PacerA lua ' .. ns .. '.runal()')
 vim.cmd('command! PacerStop lua ' .. ns .. '.stop()')
 vim.cmd('command! PacerStart lua ' .. ns .. '.start()')
end

return M

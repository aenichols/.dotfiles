local pacer = require("theprimeagen.xsvrooster.89pace.pacer")
local C = require("theprimeagen.xsvrooster.89pace.config")
local S = C.session

local M = {}

-- Setup point for ensuring the current api is ready to pace.
M.setup = function()
  -- commands
  C.setup_commands()
  -- initial run
  pacer.run()
  -- airline
  if C.airline_enabled ~= true then
    return
  end
  -- Create a timer handle (implementation detail: uv_timer_t).
  local timer = vim.loop.new_timer()
  -- Waits 3000ms, then repeats every defern(ms) until timer:close().
  timer:start(3000, C.defern, vim.schedule_wrap(function()
    -- check airline is loaded and is currently tracking
    if vim.g.loaded_airline ~= 1 or (vim.g.pace_section_x ~= nil and S.trackingState == 1) then
      return
    end
    pacer.refreshal()
  end))
end

return M

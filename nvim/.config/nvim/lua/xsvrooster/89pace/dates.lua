local M = {}

local epoch = os.time{year=1970, month=1, day=1, hour=0}
M.parse_json_date = function(json_date)
  local year, month, day, hour, minute, seconds = json_date:match("(%d+)%-(%d+)%-(%d+)%a(%d+)%:(%d+)%:([%d%.]+)")
  local timestamp = os.time{year = year, month = month, day = day, hour = hour, min = minute, sec = math.floor(seconds)} - epoch
  return timestamp
end

-- return the timezone offset in minutes, ie -360
M.get_timezone = function()
  local now = os.time()
  return os.difftime(now, os.time(os.date("!*t", now))) / 60
end

return M

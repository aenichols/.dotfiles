local M = {}
local epoch = os.time{year=1970, month=1, day=1, hour=0}

M.parse_json_date = function(json_date)
  local year, month, day, hour, minute, seconds = json_date:match("(%d+)%-(%d+)%-(%d+)%a(%d+)%:(%d+)%:([%d%.]+)")
  local timestamp = os.time{year = year, month = month, day = day, hour = hour, min = minute, sec = math.floor(seconds)} - epoch
  return timestamp
end

-- return the timezone offset in minutes, ie -360 or in stupid day light saving time, ie -300
M.get_timezone_offset_in_minutes = function()
  local ts = os.time()
  local utcdate   = os.date("!*t", ts)
  local localdate = os.date("*t", ts)
  localdate.isdst = false -- this is the trick
  local tz = os.difftime(os.time(localdate), os.time(utcdate))
  return tz / 60
end

M.get_last_week_start_date = function()
   local date = os.date("*t", os.time())
   date.day = date.day - (date.wday - 1) + 1 - 7
   local new_date = os.date("%y-%m-%d", os.time(date))
   return new_date
end

M.get_week_start_date = function()
   local date = os.date("*t", os.time())
   date.day = date.day - (date.wday - 1) + 1
   local new_date = os.date("%y-%m-%d", os.time(date))
   return new_date
end

return M

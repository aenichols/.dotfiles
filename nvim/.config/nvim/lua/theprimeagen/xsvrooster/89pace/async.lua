local M = {}
local co = coroutine

-- local a = require("theprimeagen.xsvrooster.89pace.async")
--  -- thunkify pacer run
--  local pr = a.wrap(function ()
--    if vim.g.loaded_airline ~= 1 then
--      return
--    end
--    pacer.run()
--  end)
--
--  -- avoid textlock
--  local vim_loop = function (f)
--    vim.schedule(f)
--  end
--
--  local async_call = function ()
--    return a.sync(function ()
--      -- composable, await other async thunks
--      a.await(pr())
--      --a.wait(vim_loop)
--    end)
--  end
--
--  -- avoid textlock
--  local main_loop = function (f)
--    -- Create a timer handle (implementation detail: uv_timer_t).
--    local timer = vim.loop.new_timer()
--    -- Waits 1000ms, then repeats every 750ms until timer:close().
--    timer:start(5000, 3000, vim.schedule_wrap(f))
--  end
--
--  main_loop(async_call())
-- use with wrap
local pong = function (func, callback)
  assert(type(func) == "function", "type error :: expected func")
  local thread = co.create(func)
  local step = nil
  step = function (...)
    local stat, ret = co.resume(thread, ...)
    assert(stat, ret)
    if co.status(thread) == "dead" then
      (callback or function () end)(ret)
    else
      assert(type(ret) == "function", "type error :: expected func")
      ret(step)
    end
  end
  step()
end

-- use with pong, creates thunk factory
M.wrap = function (func)
  assert(type(func) == "function", "type error :: expected func")
  local factory = function (...)
    local params = {...}
    local thunk = function (step)
      table.insert(params, step)
      return func(unpack(params))
    end
    return thunk
  end
  return factory
end

M.sync = M.wrap(pong)

-- many thunks -> single thunk
local join = function (thunks)
  local len = table.maxn(thunks)
  local done = 0
  local acc = {}

  local thunk = function (step)
    if len == 0 then
      return step()
    end
    for i, tk in ipairs(thunks) do
      assert(type(tk) == "function", "thunk must be function")
      local callback = function (...)
        acc[i] = {...}
        done = done + 1
        if done == len then
          step(unpack(acc))
        end
      end
      tk(callback)
    end
  end
  return thunk
end

-- sugar over coroutine
M.await = function (defer)
  assert(type(defer) == "function", "type error :: expected func")
  return co.yield(defer)
end


M.await_all = function (defer)
  assert(type(defer) == "table", "type error :: expected table")
  return co.yield(join(defer))
end

return M

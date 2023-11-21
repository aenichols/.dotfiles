-- Locals
local wezterm = require 'wezterm'
local act = wezterm.action
local work = wezterm.home_dir .. '/work'
local config = {}

-- Builder
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Sets
config.color_scheme = 'Gruvbox dark, soft (base16)'
config.default_cwd = work
config.default_prog = { 'bash' }
config.enable_tab_bar = false
config.font_size = 11.0

-- Launch Menu
config.launch_menu = {
  {
    label = 'QP',
    cwd = work .. "/QuickerPay/Source",
  },
  {
    label = 'CB',
    cwd = work .. "/QuickerPay/Source",
  },
  {
    label = 'ID',
    cwd = work .. "/QuickerPay/Source",
  },
}

-- Keymaps
config.keys = {
  {
    key = 'm',
    mods = 'CMD',
    action = act.DisableDefaultAssignment,
  },
  {
    key = 'phys:1',
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab {
        cwd = work .. '/QuickerPay/Source',
    },
  },
  {
    key = 'phys:2',
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab {
        cwd = work .. '/ConnectBooster/ConnectBooster.Frontend',
    },
  },
  {
    key = 'phys:3',
    mods = 'CTRL|SHIFT',
    action = act.SpawnCommandInNewTab {
        cwd = work .. '/Identity/src/Identity.Server',
    },
  },
}

-- Remap Tab Navigation
for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = act.ActivateTab(i - 1),
  })
end

-- Disable close confirmation
-- config.skip_close_confirmation_for_processes_named = { }
wezterm.on('mux-is-process-stateful', function()
  -- Just use the default behavior
  -- return nil
  -- false - to indicate that the process tree can be terminated without prompting the user
  return false
end)

return config

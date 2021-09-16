local utils = require('telescope.utils')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local strings = require('plenary.strings')
local entry_display = require('telescope.pickers.entry_display')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values

actions.git_fetch_branch_tolocal = function(prompt_bufnr)
  local cwd = action_state.get_current_picker(prompt_bufnr).cwd
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  local stdout, ret, stderr = utils.get_os_command_output({ 'git', 'fetch', '-f', 'origin' , selection.value .. ':' .. selection.value }, cwd)

  if ret == 0 then
    print("Finished Fetching")
    print(selection.value)
  else
    print(string.format('Error when fetching branch into local: %s', selection.value, table.concat(stderr, '  ')))
    print(string.format('Git returned: "%s"', selection.value, table.concat(stderr, '  ')))
  end
end

actions.git_merge = function(prompt_bufnr)
  local cwd = action_state.get_current_picker(prompt_bufnr).cwd
  local selection = action_state.get_selected_entry()

  local confirmation = vim.fn.input('Do you really wanna merge branch ' .. selection.value .. '? [Y/n] ')
  if confirmation ~= '' and string.lower(confirmation) ~= 'y' then return end

  actions.close(prompt_bufnr)
  local _, ret, stderr = utils.get_os_command_output({ 'git', 'merge', selection.value }, cwd)

  if ret == 0 then
    print("Merged into target: ")
    print(selection.value)
  else
    print(string.format('Error when merging branch into target: %s', selection.value, table.concat(stderr, '  ')))
    print(string.format('Git returned: "%s"', selection.value, table.concat(stderr, '  ')))
  end
end

actions.git_upstream = function(prompt_bufnr)
  local cwd = action_state.get_current_picker(prompt_bufnr).cwd
  local selection = action_state.get_selected_entry()

  local confirmation = vim.fn.input('Do you want to set the upstream to ' .. selection.value .. '? [Y/n] ')
  if confirmation ~= '' and string.lower(confirmation) ~= 'y' then return end

  actions.close(prompt_bufnr)
  print("Setting upstream to:")
  print(selection.value)
  local _, ret, stderr = utils.get_os_command_output({ 'git', 'push', '--set-upstream', 'origin', selection.value }, cwd)

  if ret == 0 then
    print("Set upstream to: ")
    print(selection.value)
  else
    print(string.format('Error while setting the upstream: %s', selection.value, table.concat(stderr, '  ')))
    print(string.format('Git returned: "%s"', selection.value, table.concat(stderr, '  ')))
  end
end

actions.git_local_branches = function()
  require("telescope.builtin").git_branches({
    prompt_title = "Git Local Branches",
    pattern = "refs/heads",
    attach_mappings = function(_, map)
      map('i', '<c-u>', actions.git_upstream)
      map('n', '<c-u>', actions.git_upstream)
      map('i', '<c-f>', actions.git_fetch_branch_tolocal)
      map('n', '<c-f>', actions.git_fetch_branch_tolocal)
      return true
    end,
  })
end

actions.search_private_proxy = function()
 local cwd = vim.loop.cwd()

 local function send_harpoon(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    require('telescope.actions').close(prompt_bufnr)
    require('harpoon.term').sendCommand(1, 'ng s --proxy-config ./.private_proxies/' .. selection.value)
 end

 require('telescope.builtin').find_files({
    prompt_title = '< Private Proxies >',
    cwd = cwd .. '/.private_proxies',
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<CR>', send_harpoon)
      map('n', '<CR>', send_harpoon)
      return true
    end
 })
end

return actions


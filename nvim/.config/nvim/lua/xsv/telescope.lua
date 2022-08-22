local utils = require('telescope.utils')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local function transform_path_sep(path)
    return path:gsub("\\", "/")
end

actions.git_fetch_branch_tolocal = function(prompt_bufnr)
  local cwd = action_state.get_current_picker(prompt_bufnr).cwd
  local selection = action_state.get_selected_entry()
  print("Fetching Into Local: " .. selection.value)
  actions.close(prompt_bufnr)
  local stdout, ret, stderr = utils.get_os_command_output({ 'git', 'fetch', '-f', 'origin' , selection.value .. ':' .. selection.value }, cwd)

  if ret == 0 then
    print("Finished Fetching Into Local: " .. selection.value)
  else
    print(string.format('Error when fetching branch into local: %s', selection.value))
    print(string.format('Git returned: "%s out: %s"', vim.inspect(stdout)))
    print(string.format('Git returned: "%s error: %s"', vim.inspect(stderr)))
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
    print("Set upstream to: " .. selection.value)
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
 local cwd = vim.env.AU

 local function send_harpoon(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    require('telescope.actions').close(prompt_bufnr)
    require('harpoon.term').sendCommand(1, 'ng s --proxy-config ./.private_proxies/' .. transform_path_sep(selection.value))
 end

 require('telescope.builtin').find_files({
    prompt_title = '< Private Proxies >',
    cwd = cwd .. '/.private_proxies',
    attach_mappings = function(_, map)
      map('i', '<c-x>', send_harpoon)
      map('n', '<c-x>', send_harpoon)
      return true
    end
 })
end

actions.search_curl_requests = function()
 local curl_files = "~/work/cURL/"
 local out_file = transform_path_sep(vim.fn.expand(curl_files .. ".out.sh"))

 local function send_request(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local selection_fpath = transform_path_sep(vim.fn.expand(curl_files .. selection.value))

    require('telescope.actions').close(prompt_bufnr)

    vim.api.nvim_command('!sh ' .. selection_fpath .. ' >> ' .. out_file .. ' 2>>&1')
 end

 require('telescope.builtin').find_files({
    prompt_title = '< cURL rEQUESTS >',
    cwd = curl_files,
    attach_mappings = function(_, map)
      map('i', '<c-x>', send_request)
      map('n', '<c-x>', send_request)
      return true
    end
 })
end

return actions


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
    print("Fetched into local: ")
    print("Finished Fetching: " ..selection.value)
  else
    print(string.format(
      'Error when fetching branch into local: %s. Git returned: "%s"',
      selection.value,
      table.concat(stderr, '  ')
    ))
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
    print(string.format(
      'Error when merging branch into target: %s. Git returned: "%s"',
      selection.value,
      table.concat(stderr, '  ')
    ))
  end
end

actions.git_upstream = function(prompt_bufnr)
  local cwd = action_state.get_current_picker(prompt_bufnr).cwd
  local selection = action_state.get_selected_entry()

  local confirmation = vim.fn.input('Do you want to set the upstream to ' .. selection.value .. '? [Y/n] ')
  if confirmation ~= '' and string.lower(confirmation) ~= 'y' then return end

  actions.close(prompt_bufnr)
  print("Setting upstream to:" .. selection.value)
  local _, ret, stderr = utils.get_os_command_output({ 'git', 'push', '--set-upstream', 'origin', selection.value }, cwd)

  if ret == 0 then
    print("Set upstream to: " .. selection.value)
  else
    print(string.format(
      'Error while setting the upstream: %s. Git returned: "%s"',
      selection.value,
      table.concat(stderr, '  ')
    ))
  end
end

actions.git_local_branches = function()

  local opts = {}

  local format = '%(HEAD)'
              .. '%(refname)'
              .. '%(authorname)'
              .. '%(upstream:lstrip=2)'
              .. '%(committerdate:format-local:%Y/%m/%d%H:%M:%S)'
  local output = utils.get_os_command_output({ 'git', 'for-each-ref', 'refs/heads', '--perl', '--format', format }, opts.cwd)

  local results = {}
  local widths = {
    name = 0,
    authorname = 0,
    upstream = 0,
    committerdate = 0,
  }
  local unescape_single_quote = function(v)
      return string.gsub(v, "\\([\\'])", "%1")
  end
  local parse_line = function(line)
    local fields = vim.split(string.sub(line, 2, -2), "''", true)
    local entry = {
      head = fields[1],
      refname = unescape_single_quote(fields[2]),
      authorname = unescape_single_quote(fields[3]),
      upstream = unescape_single_quote(fields[4]),
      committerdate = fields[5],
    }
    local prefix
    if vim.startswith(entry.refname, 'refs/remotes/') then
      prefix = 'refs/remotes/'
    elseif vim.startswith(entry.refname, 'refs/heads/') then
      prefix = 'refs/heads/'
    else
      return
    end
    local index = 1
    if entry.head ~= '*' then
      index = #results + 1
    end

    entry.name = string.sub(entry.refname, string.len(prefix)+1)
    for key, value in pairs(widths) do
      widths[key] = math.max(value, strings.strdisplaywidth(entry[key] or ''))
    end
    if string.len(entry.upstream) > 0 then
      widths.upstream_indicator = 2
    end
    table.insert(results, index, entry)
  end
  for _, line in ipairs(output) do
    parse_line(line)
  end
  if #results == 0 then
    return
  end

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 1 },
      { width = widths.name },
      { width = widths.authorname },
      { width = widths.upstream_indicator },
      { width = widths.upstream },
      { width = widths.committerdate },
    }
  }

  local make_display = function(entry)
    return displayer {
      {entry.head},
      {entry.name, 'TelescopeResultsIdentifier'},
      {entry.authorname},
      {string.len(entry.upstream) > 0 and '=>' or ''},
      {entry.upstream, 'TelescopeResultsIdentifier'},
      {entry.committerdate}
    }
  end

  pickers.new(opts, {
    prompt_title = 'Git Local Branches',
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        entry.value = entry.name
        entry.ordinal = entry.name
        entry.display = make_display
        return entry
      end
    },
    previewer = previewers.git_branch_log.new(opts),
    sorter = conf.file_sorter(opts),
    attach_mappings = function(_, map)
      actions.select_default:replace(actions.git_checkout)
      map('i', '<c-t>', actions.git_track_branch)
      map('n', '<c-t>', actions.git_track_branch)

      map('i', '<c-r>', actions.git_rebase_branch)
      map('n', '<c-r>', actions.git_rebase_branch)

      map('i', '<c-d>', actions.git_delete_branch)
      map('n', '<c-d>', actions.git_delete_branch)

      map('i', '<c-f>', actions.git_fetch_branch_tolocal)
      map('n', '<c-f>', actions.git_fetch_branch_tolocal)

      map('i', '<c-e>', actions.git_merge)
      map('n', '<c-e>', actions.git_merge)

      map('i', '<c-u>', actions.git_upstream)
      map('n', '<c-u>', actions.git_upstream)
      return true
    end
  }):find()
end

actions.search_private_proxy = function()
 local cwd = vim.loop.cwd()

 local function send_harpoon(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    require('telescope.actions').close(prompt_bufnr)
    require('harpoon.term').sendCommand(1, 'ng s --proxy-config ./private_proxy/' .. selection.value)
 end

 require('telescope.builtin').find_files({
    prompt_title = '< Private Proxies >',
    cwd = cwd .. '/private_proxy',
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<CR>', send_harpoon)
      map('n', '<CR>', send_harpoon)

      return true
    end
 })
end

return actions


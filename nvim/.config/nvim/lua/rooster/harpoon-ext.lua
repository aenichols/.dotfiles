local config = {
    create_with = ":term bash"
}

local M = {}
local terminals = {}

local function create_terminal(create_with)
    if not create_with then
        create_with = config.create_with
    end

    local current_id = vim.api.nvim_get_current_buf()

    vim.cmd(create_with)
    local buf_id = vim.api.nvim_get_current_buf()
    local term_id = vim.b.terminal_job_id

    if term_id == nil then
        return nil
    end

    -- Make sure the term buffer has "hidden" set so it doesn't get thrown
    -- away and cause an error
    vim.api.nvim_buf_set_var(buf_id, "bufhidden", "hide")

    -- Sets the current buffer if the current one is invalid.
    if not vim.api.nvim_buf_is_valid(current_id) then
        current_id = vim.api.nvim_create_buf(true, false)
    end

    -- Resets the buffer back to the old one
    vim.api.nvim_set_current_buf(current_id)
    return buf_id, term_id
end

local function find_terminal(args)
    if type(args) == "number" then
        args = { idx = args }
    end
    local term_handle = terminals[args.idx]
    if not term_handle or not vim.api.nvim_buf_is_valid(term_handle.buf_id) then
        local buf_id, term_id = create_terminal(args.create_with)
        if buf_id == nil then
            error("Failed to find and create terminal.")
            return
        end

        term_handle = {
            buf_id = buf_id,
            term_id = term_id,
        }
        terminals[args.idx] = term_handle
    end
    return term_handle
end

function M.gotoTerminal(idx)
    local term_handle = find_terminal(idx)

    if term_handle == nil then
        return
    end

    vim.api.nvim_set_current_buf(term_handle.buf_id)
end

function M.sendCommand(idx, command)
    local term_handle = find_terminal(idx)

    if term_handle == nil then
        return
    end

    vim.api.nvim_chan_send(term_handle.term_id, command)
end

return M

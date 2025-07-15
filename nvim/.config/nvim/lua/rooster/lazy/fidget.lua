return {
    "j-hui/fidget.nvim",
    config = function ()
        local fidget = require("fidget")
        fidget.setup({
            notification = {
                override_vim_notify = true,
                filter = vim.log.levels.OFF,
                window = {
                    winblend = 0,
                    x_padding = 4,
                    y_padding = 2,
                    normal_hl = "",
                    border = "rounded",
                }
            }
        })

        require("telescope").load_extension("fidget")

        vim.notify_once = fidget.notify
        -- Override print messages to notify, clean up messages, parse tables
        local _print = _G.print
        local clean_string = function(...)
            local args = {n = select("#", ...), ...}
            local formatted_args = {}
            for i = 1, args.n do
                local item = select(i, ...)
                if not item then item = 'nil' end
                local t_item = type(item)
                if t_item == 'table' or t_item == 'function' or t_item == 'userdata' then
                    item = vim.inspect(item)
                else
                    item = string.format("%s", item)
                end
                table.insert(formatted_args, item)
            end
            return table.concat(formatted_args, ' ')
        end
        _G.print = function(...)
            local msg = clean_string(...)
            vim.notify(msg)
        end
    end
}

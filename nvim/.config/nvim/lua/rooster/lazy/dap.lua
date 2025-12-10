vim.api.nvim_create_augroup("DapGroup", { clear = true })

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        ----------------------------------------------------------------------
        -- dap ui
        ----------------------------------------------------------------------
        dapui.setup({
            icons = {
                expanded = "▾",
                collapsed = "▸",
                current_frame = "*",
            },
            controls = {
                icons = {
                    pause      = "⏸ ␣dP",  -- Keymap: <leader>dP
                    play       = "▶ F5",   -- Keymap: <F5>
                    step_into  = "⏎ F1",   -- Keymap: <F1>
                    step_over  = "⏭ F2",   -- Keymap: <F2>
                    step_out   = "⏮ F3",   -- Keymap: <F3>
                    step_back  = "b ␣db",  -- Keymap: <leader>db
                    run_last   = "▶▶ ␣dl", -- Keymap: <leader>dl
                    terminate  = "⏹ ␣dt",  -- Keymap: <leader>dt
                    disconnect = "⏏ ␣dD",  -- Keymap: <leader>dD
                },
            },
        })

        ----------------------------------------------------------------------
        -- virtual text
        ----------------------------------------------------------------------
        require("nvim-dap-virtual-text").setup()

        ----------------------------------------------------------------------
        -- windows shellslash
        ----------------------------------------------------------------------
        vim.cmd([[ let &shellslash = 0 ]])

        ----------------------------------------------------------------------
        -- c# debug adapter configuration
        ----------------------------------------------------------------------
        dap.adapters.netcoredbg = {
            type = "executable",
            command = "netcoredbg",
            args = { "--interpreter=vscode" },
        }

        -- alias for compatibility
        dap.adapters.coreclr = dap.adapters.netcoredbg

        ----------------------------------------------------------------------
        -- helper: find quickerpay process
        ----------------------------------------------------------------------
        local function find_quickerpay_process()
            -- Try to find QuickerPay process automatically
            local handle = io.popen(
                'powershell "Get-Process | Where-Object {$_.ProcessName -like \'*QuickerPay*\'} | ' ..
                'Select-Object -First 1 -ExpandProperty Id"'
            )

            if handle then
                local pid = handle:read("*a")
                handle:close()

                if pid and pid:match("%d+") then
                    return tonumber(pid:match("%d+"))
                end
            end

            return nil
        end

        ----------------------------------------------------------------------
        -- helper: process selection
        ----------------------------------------------------------------------
        local function select_quickerpay_process()
            local auto_pid = find_quickerpay_process()

            if auto_pid then
                local confirm = vim.fn.input(
                    string.format("Found QuickerPay process %d. Use it? (y/n): ", auto_pid)
                )

                if confirm:lower() == "y" or confirm == "" then
                    return auto_pid
                end
            end

            return tonumber(vim.fn.input("Process ID (QuickerPay API on :50838): "))
        end

        ----------------------------------------------------------------------
        -- helper: get project root
        ----------------------------------------------------------------------
        local function get_project_root()
            return vim.fn.getcwd()
        end

        ----------------------------------------------------------------------
        -- c# debug configurations
        ----------------------------------------------------------------------
        dap.configurations.cs = {
            {
                type = "coreclr",
                request = "launch",
                name = "Launch QuickerPay API",
                cwd = function()
                    return get_project_root()
                        .. "/QuickerPay.TenantPortal/bin/Debug/net8.0"
                end,
                program = function()
                    return get_project_root()
                        .. "/QuickerPay.TenantPortal/bin/Debug/net8.0/QuickerPay.TenantPortal.dll"
                end,
                sourceFileMap = {
                    ["/_/"] = get_project_root(),   -- most common required map for .NET builds
                },
                env = {
                    ASPNETCORE_ENVIRONMENT = "Development",
                    ASPNETCORE_URLS = "http://localhost:50838",
                },
            },
            {
                request = "attach",
                type = "netcoredbg",
                name = "Attach to QuickerPay API (Auto-detect)",
                processId = select_quickerpay_process,
                cwd = get_project_root()
                    .. "/QuickerPay.TenantPortal/bin/Debug/net8.0",
                program = get_project_root()
                    .. "/QuickerPay.TenantPortal/bin/Debug/net8.0/QuickerPay.TenantPortal.dll",
            },
            {
                request = "attach",
                type = "netcoredbg",
                name = "Attach to QuickerPay API (Manual PID)",
                cwd = get_project_root()
                    .. "/QuickerPay.TenantPortal/bin/Debug/net8.0",
                processId = function()
                    return tonumber(vim.fn.input("Process ID "))
                end,
                program = get_project_root()
                    .. "/QuickerPay.TenantPortal/bin/Debug/net8.0/QuickerPay.TenantPortal.dll",
            },
        }

        ----------------------------------------------------------------------
        -- auto-open/close dap ui
        ----------------------------------------------------------------------
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        dap.listeners.after.event_output.dapui_config = function(_, body)
            if body.category == "console" then
                dapui.eval(body.output) -- Sends stdout/stderr to Console
            end
        end

        ----------------------------------------------------------------------
        -- fix ^M by treating dap repl output as dos/windows-style line endings
        ----------------------------------------------------------------------
        vim.api.nvim_create_autocmd("BufEnter", {
            group = "DapGroup",
            pattern = "*dap-repl*",
            callback = function()
                vim.wo.wrap = true
            end,
        })

        -- strip ^M (carriage returns) from dap-repl output
        vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
            group = "DapGroup",
            pattern = "*dap-repl*",
            callback = function()
                -- remove trailing \r characters silently
                vim.cmd([[silent! %s/\r$//g]])
            end,
        })


        ----------------------------------------------------------------------
        -- keymaps
        ----------------------------------------------------------------------
        -- core run controls
        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug Play or Continue ▶", })
        vim.keymap.set("n", "<leader>dP", dap.pause, { desc = "Debug Pause ⏸", })
        vim.keymap.set("n", "<leader>dD", dap.disconnect, { desc = "Debug Disconnect ⏏", })
        vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug Terminate ⏹", })

        -- stepping
        vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug Step Into ⏎", })
        vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug Step Over ⏭", })
        vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug Step Out ⏮", })
        vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Debug Step Back", })

        -- breakpoints
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug Toggle Breakpoint", })
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition "))
        end, { desc = "Debug Set Conditional Breakpoint", })

        -- dap ui toggle
        vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug Toggle DAP UI", })

        -- additional debugging shortcuts
        vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug Open REPL", })
        vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug Run Last ▶▶", })
        vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "Debug Clear All Breakpoints", })

        -- hover during debugging
        vim.keymap.set({ "n", "v" }, "<leader>dh", require("dap.ui.widgets").hover, { desc = "Debug Hover", })
        vim.keymap.set({ "n", "v" }, "<leader>dp", require("dap.ui.widgets").preview, { desc = "Debug Preview", })

        -- frames and scopes in floating windows
        vim.keymap.set("n", "<leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end, { desc = "Debug Frames", })
        vim.keymap.set("n", "<leader>ds", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end, { desc = "Debug Scopes", })
    end,
}

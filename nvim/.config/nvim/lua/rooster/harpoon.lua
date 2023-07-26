require("harpoon").setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    },
    global_settings = {
        create_with = ":terminal bash",
        enter_on_sendcmd = true,
    },
    projects = {
        ["C:\\Users\\anthony.nichols\\work\\ConnectBooster\\ConnectBooster.Frontend"] = {
            term = {
                cmds = {
                    "ng s",
                    "eslint --fix ",
                    "npm run test -- ",
                }
            }
        },
        ["C:\\Users\\anthony.nichols\\work\\Identity\\src\\Identity.Server"] = {
            term = {
                cmds = {
                    "clear && dotnet build && dotnet run",
                    "expect -c \"send \003;\"; clear && dotnet build && dotnet run",
                }
            }
        },
        ["C:\\Users\\anthony.nichols\\work\\QuickerPay\\Source"] = {
            term = {
                cmds = {
                    "clear && qp build tp",
                    "clear && qp build tp && qp start",
                    "expect -c \"send \003;\"; clear && qp build tp && qp start",
                }
            }
        }
    }
})

require("harpoon").setup({
    global_settings = {
        create_with = ":terminal bash",
        enter_on_sendcmd = true,
    },
    projects = {
        ["$HOME/work/ConnectBooster/ConnectBooster.Frontend"] = {
            term = {
                cmds = {
                    "ng s",
                    "eslint --fix ",
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

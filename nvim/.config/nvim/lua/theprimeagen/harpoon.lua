
require("harpoon").setup({
    projects = {
        ["$HOME/Source/ConnectBooster/ConnectBooster.Frontend"] = {
            term = {
                cmds = {
                    "ng s",
                    "eslint --fix ",
                }
            }
        }
    }
})


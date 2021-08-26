
require("harpoon").setup({
    projects = {
        ["$HOME/work/ConnectBooster/ConnectBooster.Frontend"] = {
            term = {
                cmds = {
                    "ng s",
                    "eslint --fix ",
                }
            }
        }
    }
})


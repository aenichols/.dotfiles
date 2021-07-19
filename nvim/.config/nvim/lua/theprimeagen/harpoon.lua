
require("harpoon").setup({
    projects = {
        ["C:\\Source\\ConnectBooster\\ConnectBooster.Frontend"] = {
            term = {
                cmds = {
                    "ng s",
                    "eslint --fix ",
                }
            }
        }
    }
})


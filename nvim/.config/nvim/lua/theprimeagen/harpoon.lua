
require("harpoon").setup({
    projects = {
        ["$HOME/work/ConnectBooster/ConnectBooster.Frontend"] = {
            term = {
                cmds = {
                    "ng s",
                    "eslint --fix ",
                }
            }
        },
        ["C:\\Users\\anthony.nichols\\work\\ConnectBoosterVNext\\src\\ConnectBooster.Identity"] = {
            term = {
                cmds = {
                    "ng s",
                    "eslint --fix ",
                }
            }
        }
    }
})


return {
    "nvimtools/hydra.nvim",
    config = function()
        local Hydra = require("hydra")

        Hydra({
            name = "Windows",
            body = "<leader>w",
            heads = {
                { "h", "<C-w>h" },
                { "j", "<C-w>j" },
                { "k", "<C-w>k" },
                { "l", "<C-w>l" },

                { "H", "<C-w>H" },
                { "J", "<C-w>J" },
                { "K", "<C-w>K" },
                { "L", "<C-w>L" },

                { "<", "<C-w><" },
                { ">", "<C-w>>" },
                { "=", "<C-w>=" },
            }
        })
    end
}

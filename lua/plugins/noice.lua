return -- lazy.nvim
{
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        setup = function()
            local Popup = require("nui.popup")

            local popup = Popup({
                position = {
                    row = 50,
                    col = 20,
                },

            })
        end
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    }
}

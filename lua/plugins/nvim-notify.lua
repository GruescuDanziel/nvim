return {

    'rcarriga/nvim-notify',

    config = function()
        require("notify").setup({
            stages = "slide",
            timeout = 3000,
            background_colour = "#000000",
            top_down = false,
        })
        vim.notify = require("notify")
    end,
}

return {

    "nvim-tree/nvim-tree.lua",

    config = function ()
        require("nvim-tree").setup()
        local nvimTreeApi = require "nvim-tree.api"
        vim.keymap.set("n", "<leader><leader>", nvimTreeApi.tree.toggle)

    end

}

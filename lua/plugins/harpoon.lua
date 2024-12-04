return {"ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
        local builtin = require('harpoon')
        vim.keymap.set("n", "<leader>a", function() builtin:list():add() end)
        vim.keymap.set("n", "<C-x>", function() builtin.ui:toggle_quick_menu(builtin:list()) end)
    end
}

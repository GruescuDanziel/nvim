return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()

        vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", {desc = "Check Change"})
        vim.keymap.set("n", "<leader>gi", ":Gitsigns blame_line<CR>", {desc = "Blame line"})
    end,
}

return {
    "David-Kunz/jester",
    config = function()
        vim.keymap.set("n", "<leader>jf", "::lua require'jester'.run_file()<CR>")
        vim.keymap.set("n", "<leader>js", ":lua require'jester'.run()<CR>")
        vim.keymap.set("n", "<leader>jd", ":lua require'jester'.debug({ dap = { type = 'pwa-node' } })')<CR>")
        vim.keymap.set("n", "<leader>jc", ":JestCoverageCR>")
        vim.keymap.set("n", "<leader>jp", ":Jest<CR>")
    end,
}

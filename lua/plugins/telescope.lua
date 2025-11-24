return {
    'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {"<leader><leader>", "<cmd>Telescope find_files<CR>", desc = "Fuzzy Find Files"},
        {"<TAB><TAB>", "<CMD>Telescope buffers<CR>", desc = "Select Buffer"},
    }
}

return {
    "neovim/nvim-lspconfig",
    keys = {

        {"<C-t>", "<CMD>Telescope lsp_type_definitions<CR>"},
        {"<C-b>", "<CMD>Telescope lsp_definitions<CR>"},
        {"<C-u>", "<CMD>Telescope lsp_references<CR>"}

    }
}

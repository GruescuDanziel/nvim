return {

    'camgraff/telescope-tmux.nvim',

    config = function ()
        vim.keymap.set("n", "<leader>tw", ":Telescope tmux windows<CR>", {desc = "Change between tmux windows"})
    end

}

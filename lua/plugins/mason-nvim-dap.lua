return {
    "jay-babu/mason-nvim-dap.nvim",

    config = function ()

        require("mason").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = { "js" }, -- installs vscode-js-debug
            automatic_installation = true,
            handlers = {
            function(config)
                require("mason-nvim-dap").default_setup(config)
            end,
            },
        })
    end
}

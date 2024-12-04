return {
    "mfussenegger/nvim-dap",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "mxsdev/nvim-dap-vscode-js",
        "tpope/vim-fugitive",
        "folke/trouble.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("dapui").setup()
        require("dap-go").setup()

        require("dap-vscode-js").setup({
            adapters = {"node2","pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
            debugger_path = "/Users/gruescuipatie/.local/share/debuger"
        })

        for _, language in ipairs({ "typescript", "javascript" }) do
            require("dap").configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach",
                    processId = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Debug Jest Tests",
                    -- trace = true, -- include debugger info
                    runtimeExecutable = "node",
                    runtimeArgs = {
                        "./node_modules/jest/bin/jest.js",
                        "--runInBand",
                    },
                    rootPath = "${workspaceFolder}",
                    cwd = "${workspaceFolder}",
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                },
            }
        end

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    end,
}

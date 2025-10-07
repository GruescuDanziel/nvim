return {
    "mfussenegger/nvim-dap",
    config = function ()
        local dap = require("dap")
        dap.configurations.javascript = {
        {
            name = "Launch file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            name = "Attach to process",
            type = "pwa-node",
            request = "attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
        }

    dap.configurations.typescript = dap.configurations.javascript
end
}

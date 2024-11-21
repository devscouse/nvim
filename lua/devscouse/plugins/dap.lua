return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"
            require("dapui").setup()
            require("dap-python").setup("python")
            require("dap-python").test_runner = "pytest"

            vim.keymap.set("n", "<space>bb", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>dd", dap.run_to_cursor)

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug Step [I]nto" })
            vim.keymap.set("n", "<leader>do", dap.step_over)
            vim.keymap.set("n", "<leader>dt", dap.step_out)
            vim.keymap.set("n", "<leader>db", dap.step_back)
            vim.keymap.set("n", "<leader>dr", dap.restart)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}

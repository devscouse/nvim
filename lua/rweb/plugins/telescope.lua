return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Find by Grep" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>",    desc = "Find Keymaps" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "Find Recent Files" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Find Help Tags" },
    },
    config = function()
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope-themes').get_drop_down {
                winblend = 10,
                previewer = false,
            })
        end, { desc = "Fuzzy search in current buffer" })

        vim.keymap.set(
            "n",
            "<leader>fc",
            function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
            { desc = "Find Neovim Config Files" }
        )
    end,
}

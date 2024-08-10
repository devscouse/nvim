return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { "<leader>fb",  "<cmd>Telescope buffers<cr>",                 desc = "[F]ind [B]uffers" },
        { "<leader>ff",  "<cmd>Telescope find_files<cr>",              desc = "[F]ind [F]iles" },
        { "<leader>fa",  "<cmd>Telescope find_files hidden=true <cr>", desc = "[F]ind [A]ll files" },
        { "<leader>fg",  "<cmd>Telescope live_grep<cr>",               desc = "[F]ind by [G]rep" },
        { "<leader>fk",  "<cmd>Telescope keymaps<cr>",                 desc = "[F]ind [K]eymaps" },
        { "<leader>fr",  "<cmd>Telescope oldfiles<cr>",                desc = "[F]ind [R]ecent Files" },
        { "<leader>fh",  "<cmd>Telescope help_tags<cr>",               desc = "[F]ind [H]elp Tags" },
        { "<leader>fgc", "<cmd>Telescope git_commits<cr>",             desc = "[F]ind [G]it [C]ommits" },
        { "<leader>f.",  "<cmd>Telescope resume<cr>",                  desc = "[F]ind resume" },
    },
    config = function()
        local builtin = require 'telescope.builtin'
        local actions = require 'telescope.actions'
        local themes = require 'telescope.themes'

        require('telescope').setup {
            filters = { dotfiles = false },
            defaults = {
                layout_strategy = 'flex',
                layout_config = {
                    height = 0.95,
                    width = 0.95,
                    prompt_position = 'bottom',
                    flip_columns = 100,
                    horizontal = { preview_width = 0.7, preview_cutoff = 60 },
                    vertical = { preview_height = 0.5, preview_cutoff = 20 },
                },
                mappings = {
                    i = {
                        ["<S-Tab>"] = {
                            actions.move_selection_next, type = "action",
                            opts = { nowait = true, silent = true }
                        },
                        ["<Tab>"] = {
                            actions.move_selection_previous, type = "action",
                            opts = { nowait = true, silent = true }
                        },
                        ["jk"] = "close",
                        ["<C-s>"] = "toggle_selection",
                        ["<C-Q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<C-q>"] = "open_qflist",
                    },
                },
            },
            pickers = {
                find_files = {
                    mappings = {
                        i = {
                            ["<S-Tab>"] = {
                                actions.move_selection_next, type = "action",
                                opts = { nowait = true, silent = true }
                            },
                            ["<Tab>"] = {
                                actions.move_selection_previous, type = "action",
                                opts = { nowait = true, silent = true }
                            },
                            ["jk"] = "close",
                            ["<C-s>"] = "toggle_selection",
                            ["<C-Q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<C-q>"] = "open_qflist",
                        },
                    },
                },
            },
        }

        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(themes.get_drop_down {
                winblend = 10,
                previewer = false,
            })
        end, { desc = "Fuzzy search in current buffer" })

        vim.keymap.set(
            "n",
            "<leader>fc",
            function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
            { desc = "[F]ind Neovim [C]onfig Files" }
        )
    end,
}

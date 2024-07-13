return {
    { 'tpope/vim-sleuth' },
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require('mini.ai').setup { n_lines = 500 }
            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup()

            local sline = require 'mini.statusline'
            sline.setup { use_icons = vim.g.have_nerd_font }
            sline.section_location = function() return '%2l:%-2v' end

            -- Animate common vim motions
            require('mini.animate').setup()

            -- Extend f, F, t, T to work on multiple lines
            --
            -- Repeat hump by pressing f, F, t, T again
            require('mini.jump').setup()
        end,
    },
    { "eandrju/cellular-automaton.nvim" },
    {
        "theprimeagen/vim-be-good",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {}
        end,
    },
}

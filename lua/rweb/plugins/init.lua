return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            require('mini.pairs').setup({})
        end,
    },
    {"eandrju/cellular-automaton.nvim"},
    {
        "theprimeagen/vim-be-good",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

    },
}

return {
    "tpope/vim-fugitive",
    keys={
        {"<leader>gs", vim.cmd.Git, desc = "Git Status"},
        {"<leader>ga", ":Git add .<CR>", desc = "Git Add All"},
    }
}

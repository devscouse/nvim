return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n",
            "<leader>gs",
            vim.cmd.Git,
            { desc = "[G]it [S]tatus" }
        )

        local DevScouse_Fugitive = vim.api.nvim_create_augroup(
            "DevScouse_Fugitive",
            {}
        )

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = DevScouse_Fugitive,
            pattern = "*",
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                local function get_opts(desc)
                    return { buffer = buf, remap = false, desc = desc }
                end

                if vim.bo.ft ~= "fugitive" then
                    return
                end

                vim.keymap.set(
                    "n",
                    "<leader>gp",
                    function() vim.cmd.Git('push') end,
                    get_opts("[G]it [P]ush")
                )

                -- rebase always
                vim.keymap.set(
                    "n",
                    "<leader>gP",
                    function() vim.cmd.Git({ 'pull', '--rebase' }) end,
                    get_opts("[G]it [P]ull")
                )

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n",
                    "<leader>t",
                    ":Git push -u origin ",
                    get_opts("[G]it [T]rack")
                )
            end,
        })
        vim.keymap.set("n",
            "<leader>gf",
            "<cmd>diffget //2<CR>",
            { desc = "[G]it select left diff" }
        )
        vim.keymap.set("n",
            "<leader>gj",
            "<cmd>diffget //3<CR>",
            { desc = "[G]it select right diff" }
        )
    end
}

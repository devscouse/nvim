return {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
        {
            "<leader>cf",
            function() require("conform").format { async = true, lsp_fallback = true } end,
            mode = '',
            desc = "[C]ode [F]ormat",
        },
    },
    opts = {
        notify_on_error = true,
        format_on_save = function(bufnr)
            local disable_filetypes = { c = true, cpp = true }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
        end,
        formatters_by_ft = {
            lua = { 'stylelua' },
            python = { 'ruff', 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        },
    },
}

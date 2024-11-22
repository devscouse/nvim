return {
    'stevearc/conform.nvim',
    opts = {
        notify_on_error = true,
    },
    events = { "BufReadPre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function() require("conform").format { async = true, lsp_fallback = true } end,
            mode = '',
            desc = "[C]ode [F]ormat",
        },
    },
    config = function()
        require("conform").setup {
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                return {
                    timeout_ms = 5000,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { 'stylelua' },
                python = {
                    -- To fix auto-fixable lint errors.
                    "ruff_fix",
                    -- To run the Ruff formatter.
                    "ruff_format",
                    -- To organize the imports.
                    "ruff_organize_imports",
                },
            }
        }
    end
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        'hrsh7th/cmp-buffer',
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets"
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        require('mason').setup()
        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup {
            ensure_installed = {
                "pyright",
                "ruff_lsp",
            }
        }
        local on_attach = function(client, bufnr)
            if client.name == 'ruff_lsp' then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
            end
        end

        require('luasnip').setup {
            require('luasnip.loaders.from_vscode').lazy_load()
        }

        require("lspconfig").pyright.setup {
            capabilities = capabilities,
            settings = {
                pyright = {
                    -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        -- ignore = { '*' },
                    },
                },
            },
        }
        require("lspconfig").ruff_lsp.setup {
            on_attach = on_attach,
            init_options = {
                settings = {
                    args = { }
                }
            }
        }

        -- Configure auto-completion
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- Set up completion plugin
        cmp.setup({
            enabled = function()
                -- disable completion in comments
                local context = require 'cmp.config.context'
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert ({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<s-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<c-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select=true }),
            }),
            sources = cmp.config.sources(
            {
                { name = "nvim_lsp" },
                { name = "luasnip" },
            },
            {
                { name = "buffer" },
            }
            )
        })

    end
}

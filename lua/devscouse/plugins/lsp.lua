return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        "folke/neodev.nvim",
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
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local servers = {
            clangd = {
                filetypes = { "c", "cpp" },
                cmd = { "clangd" }
            },
            lua_ls = {
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } },
                    },
                },
            },
            pyright = {
                filetypes = { "python" },
            },
            ts_ls = {
                filetypes = { "typescript" }
            },
        }

        require('mason').setup()
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, { 'stylua' })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            }
        }
        local util = require("lspconfig/util")
        require("lspconfig.configs").pylyzer = {
            default_config = {
                name = "pylyzer",
                cmd = { "pylyzer", "--server" },
                filetypes = { "python" },
                root_dir = function(fname)
                    local root_files = {
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                    }
                    return util.root_pattern(unpack(root_files))(fname)
                        or util.find_git_ancestor(fname)
                        or util.path.dirname(fname)
                end,
            },
        }
    end
}

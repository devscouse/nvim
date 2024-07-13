return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'

        cmp.setup {
            enabled = function()
                local context = require 'cmp.config.context'

                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end
            },
            mapping = cmp.mapping.preset.insert {
                -- Select the next item in the autcomplete menu
                ['<Tab>'] = cmp.mapping.select_next_item(),
                -- Select the previous item in the autocomplete menu
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                -- Scroll the documentation window forward
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                -- Scroll the documentation window backward
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                -- Accept the selected completion
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                -- Close the autcomplete window
                ['<C-e>'] = cmp.mapping.abort(),
                -- Move to the right of your snippet expansion
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expanded_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                -- Move to the left of your snippet expansion
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            },
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
                {
                    { name = 'buffer' },
                }
            ),
        }
    end,
}

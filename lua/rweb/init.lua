require('rweb.lazy')
require('rweb.remap')
require('rweb.set')

-- Set the colour theme
vim.cmd [[colorscheme kanagawa]]

-- Create autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local rweb_group = augroup('RWebGroup', {})
local highlight_group = augroup('YankHighlight', { clear = true })

autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

autocmd('LspAttach', {
    group = rweb_group,
    callback = function(e)
        -- Helper function for creating a mapping for insert mode
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = e.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor
        map('gd', require('telescope.builtin').lsp_definitions, "Go to Definitions")

        -- Find references for the word under your cusro
        map('gr', require('telescope.builtin').lsp_references, "Go to References")

        -- Fuzzy find all the symbols in your current document
        -- Symbols are things like variables, functions, types, etc
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, "Find Document Symbols")

        -- Fuzzy find all the symbols in your current workspace
        map('<leader>ws', require('telescope.builtin').lsp_document_symbols, "Find Workspace Symbols")

        -- Rename the variable under your cursor
        map('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')

        -- Execute a code action
        map('<leader>ca', vim.lsp.buf.code_action, "Code Action")

        -- Opens a popup to display documentation about the word under your cursor
        -- See `:h K' for why this keymap is used
        map('K', vim.lsp.buf.hover, "Hover Documentation")

        -- This is not go to definition, this is go to declaration
        map('gD', vim.lsp.buf.declaration, "Go to Declaration")

        local opts = { buffer = e.buf }
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
})

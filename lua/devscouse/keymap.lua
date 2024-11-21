local set = vim.keymap.set

vim.g.mapleader = " "
set("i", "jk", "<Esc>")

-- Move visual blocks around together
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste without removing the yank
set("x", "<leader>p", [["_dP]])

-- Yank text into the clipboard
set({ "n", "v" }, "<leader>y", [["+y]])

set("n", "Q", "<nop>")
set("n", "<leader>cf", vim.lsp.buf.format)

set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

set({ 'n', 'v' }, '<Space>', '<Nop>')
set('t', '<Esc>', "<C-\\><C-n>")
set('t', '<C-w>', "<C-\\><C-n><C-w>")

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = "Got to previous diagnostic" })
set('n', ']d', vim.diagnostic.goto_next, { desc = "Got to next diagnostic" })
set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

set('n', '<leader>sa', 'ggVG', { desc = '[S]elect [A]ll' })

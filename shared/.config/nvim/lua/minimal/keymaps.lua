-- =================================
-- Keymaps
-- =================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Save and reload config' })
vim.keymap.set('x', 'p', [["_dP]], { desc = 'Paste over selection without losing yanked text' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and keep selection' })
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { silent = true, desc = 'Trigger built-in LSP completion' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format file' })
-- vim.keymap.set('i', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

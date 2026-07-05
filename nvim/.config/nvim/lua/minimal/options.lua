require('vim._core.ui2').enable({})

--[[
==================================================================
Option
==================================================================
]]
vim.g.loaded_netrwPlugin = 0
vim.o.nu = true
vim.o.rnu = true

-- Fold setup >
vim.o.foldmethod = 'expr'
vim.o.foldlevel = 99 -- prevent open file on fold mode
vim.o.foldcolumn = '1'
-- Set the icons for open, closed, and internal fold lines
--  is a down chevron,  is a right chevron
vim.opt.fillchars:append({ foldopen = '', foldclose = '', foldsep = ' ' })
-- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- <

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.winborder = 'rounded'
vim.o.wrap = true
vim.o.smartindent = true
vim.o.inccommand = 'split'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 3
vim.o.scrolloff = 5
vim.o.colorcolumn = ''
vim.o.signcolumn = 'yes'
vim.o.cmdheight = 0
vim.o.termguicolors = true
vim.opt.isfname:append('@-@')
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.o.undofile = true

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

vim.diagnostic.config({ virtual_text = true }) -- show diagnostics as virtual text

vim.o.completeopt = 'menuone,noselect,fuzzy,nosort'
vim.opt.shortmess:append('c')
vim.o.mouse = 'a'
-- vim.o.cursorline = true
-- vim.o.autoindent = true
-- vim.o.breakindent = true
-- vim.o.autocomplete = true

-- transparent bg
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])

--[[
==================================================================
Keymaps
==================================================================
]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = 'Save and reload config' })
vim.keymap.set('n', 'gb', 'C-o', { desc = 'Jump back to previous file' })
vim.keymap.set('x', 'p', [["_dP]], { desc = 'Paste over selection without losing yanked text' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and keep selection' })
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { silent = true, desc = 'Trigger built-in LSP completion' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format file' })
vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, { desc = 'Rename symbol' })
-- vim.keymap.set(
--     { 'n', 'v', 'i' },
--     '<D-.>',
--     function() vim.lsp.buf.code_action() end,
--     { desc = 'LSP code actions (quick fix)' }
-- )
-- vim.keymap.set(
--     { 'n', 'v', 'i' },
--     '<M-.>',
--     function() vim.lsp.buf.code_action() end,
--     { desc = 'LSP code actions (quick fix)' }
-- )
vim.keymap.set(
    { 'n', 'v', 'i' },
    '<C-.>',
    function() vim.lsp.buf.code_action() end,
    { desc = 'LSP code actions (quick fix)' }
)
vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'LSP code actions' })
vim.keymap.set('i', '<Esc>', '<Esc><cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

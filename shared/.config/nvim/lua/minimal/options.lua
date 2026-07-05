require('vim._core.ui2').enable({})

-- =================================
-- Option
-- =================================
vim.g.loaded_netrwPlugin = 0
vim.o.nu = true
vim.o.rnu = true
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

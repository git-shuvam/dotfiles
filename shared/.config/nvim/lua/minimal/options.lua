--[[
==================================================================
Option
==================================================================
]]
vim.g.netrw_banner = 0
local o = vim.o
local opt = vim.opt

vim.g.loaded_netrwPlugin = 0
o.nu = true
o.rnu = true

-- Fold setup >
o.foldmethod = "expr"
o.foldlevel = 99 -- prevent open file on fold mode
o.foldcolumn = "1"
-- Set the icons for open, closed, and internal fold lines
--  is a down chevron,  is a right chevron
vim.opt.fillchars:append({ foldopen = "", foldclose = "", foldsep = " " })
-- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- <

-- Tab Options
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.wrap = false
o.smartindent = true
o.inccommand = "split"

-- Buffer split
o.splitright = true
o.splitbelow = true

-- case sensitivity search
o.ignorecase = true
o.smartcase = true
o.laststatus = 3

o.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath("data") .. "/undodir"
o.undofile = true

opt.clipboard:append("unnamedplus")
opt.isfname:append("@-@")
o.guicursor = ""
o.scrolloff = 5

o.colorcolumn = "0"
o.signcolumn = "yes"
o.cmdheight = 0
o.termguicolors = true

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

o.winborder = "rounded"

vim.diagnostic.config({ virtual_text = true }) -- show diagnostics as virtual text

o.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")
o.mouse = "a"
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
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>", { desc = "Save and reload config" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlight", silent = true })

vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "gb", "C-o", { desc = "Jump back to previous file" })
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { silent = true, desc = "Trigger built-in LSP completion" })
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })
vim.keymap.set(
  { "n", "v", "i" },
  "<C-.>",
  function() vim.lsp.buf.code_action() end,
  { desc = "LSP code actions (quick fix)" }
)

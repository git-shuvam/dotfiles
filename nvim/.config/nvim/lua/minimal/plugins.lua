--[[
==================================================================
ColorScheme
==================================================================
]]
-- vim.cmd([[colorscheme retrobox]]) -- tokyonight-night, miniautumn, miniwinter

--[[
==================================================================
LSP
==================================================================
]]

vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
})
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        -- 'prettier',
        -- 'shfmt',
        'emmet_ls',
        'html',
        'just',
        'lua_ls',
        'ruff',
        'rust_analyzer',
        'ts_ls',
        'ty',
    },
})

--[[
==================================================================
FileTree
==================================================================
]]

vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

---@type snacks.Config.base
local snacks = {
    explorer = { enabled = true, replace_netrw = true },
    picker = { enabled = true, sources = { explorer = { hidden = true, ignored = true } } },
    dashboard = {
        enabled = true,
        sections = {
            { section = 'header' },
            { section = 'keys', gap = 1, padding = 1 },
            { section = 'recent_files', icon = ' ', title = 'Recent Files', indent = 2 },
            { section = 'projects', icon = ' ', title = 'Projects', indent = 2 },
        },
    },
}
require('snacks').setup(snacks)
vim.keymap.set('n', '<leader><leader>', function() Snacks.explorer() end, { desc = 'Toggle Snacks Eplorer' })

--[[
Tab Bar
]]

vim.pack.add({ 'https://github.com/akinsho/bufferline.nvim' })

require('bufferline').setup({
    options = {
        mode = 'buffers',
        separator_style = 'slope', -- slant, slope, thick, thin
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        diagnostics = 'nvim_lsp',
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        offsets = {
            {
                filetype = 'snacks_layout_box',
                text = 'File Explorer',
                text_align = 'left',
                separator = true,
            },
        },
    },
})

-- 3. Quick keybindings to swap tabs like a browser
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous Tab' })

--[[
==================================================================
Status Bar
==================================================================
]]
vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })
require('lualine').setup({
    always_divide_middle = true,
    globalstatus = true,
    sections = {
        lualine_a = { {
            'mode',
            fmt = function(str) return str:sub(1, 1) end,
        } },
        lualine_b = { 'branch' },
        lualine_y = { 'filename', 'filetype' },
    },
})

--[[
==================================================================
Git signs
==================================================================
]]
vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })
require('gitsigns').setup({
    signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
    },
    signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300,
        virt_text_pos = 'eol',
    },
})

--[[
==================================================================
Mini.nvim
==================================================================
]]
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

---- mini complitions ----
local MiniCompetion = require('mini.completion')
MiniCompetion.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return MiniCompetion.default_process_items(items, base, { filtersort = 'fuzzy' })
        end,
    },
})

-- ---- mini extra ----
-- require('mini.extra').setup()
-- vim.keymap.set('n', '<leader>xx', function() MiniExtra.pickers.diagnostic() end, { desc = 'Mini Picker' })
-- vim.keymap.set('n', '<leader>pk', function() MiniExtra.pickers.keymaps() end, { desc = 'Search keaymaps' })

---- mini icons ----
local MiniIcons = require('mini.icons')
MiniIcons.setup({})
MiniIcons.mock_nvim_web_devicons()

---- mini notify ----
require('mini.notify').setup({ content = { format = function(notif) return notif.msg end } }) -- only show messages

-- ---- mini pick ----
-- local MiniPicker = require('mini.pick')
-- MiniPicker.setup()
-- vim.keymap.set('n', '<leader>pf', function() MiniPicker.builtin.files() end, { desc = 'Mini File picker' })
-- vim.keymap.set(
--     'n',
--     '<leader>ps',
--     function() MiniPicker.builtin.grep({ pattern = vim.fn.expand('<cword>') }) end,
--     { desc = 'Mini Grep picker' }
-- )
-- vim.keymap.set('n', '<leader>vh', function() MiniPicker.builtin.help() end, { desc = 'Mini Help' })

-- ---- mini surround ----
-- require('mini.surround').setup({
--     highlight_duration = 500,
--     mappings = {
--         add = 'sa',
--         delete = 'sd',
--         find = 'sf',
--         find_left = 'sF',
--         replace = 'sr',
--         suffix_last = 'l',
--         suffix_next = 'n',
--     },
--     search_method = 'cover',
--     silent = false,
-- })
-- Default keymap
-- | `sa` | Add surrounding                 |
-- | `sd` | Delete surrounding              |
-- | `sr` | Replace surrounding             |
-- | `sf` | Find surrounding (right)        |
-- | `sF` | Find surrounding (left)         |
-- | `sh` | Highlight surrounding           |
-- | `sn` | Update n_lines                  |
-- | `l` / `n` | as suffix for prev/next    |

--[[
==================================================================
Markdown
==================================================================
]]
vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
    latex = { enabled = false },
    bullet = { enabled = true },
    checkbox = {
        enabled = true,
        position = nil,
        unchecked = { icon = ' 󰄱 ', highlight = 'RenderMarkdownUnchecked', scope_highlight = nil },
        checked = { icon = ' 󰱒 ', highlight = 'RenderMarkdownChecked', scope_highlight = nil },
    },
    html = { enabled = false, comment = { conceal = false } },
    yaml = { enabled = false },
    link = { image = '󰥶 ' },
    heading = { sign = true, icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' }, backgrounds = {} },
})

--[[
==================================================================
WhichKey
==================================================================
]]
vim.pack.add({ 'https://github.com/folke/which-key.nvim' })
vim.keymap.set(
    'n',
    '<leader>?',
    function() require('which-key').show() end,
    { desc = 'Buffer Local Keymaps (which-key)' }
)

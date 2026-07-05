---- mini icons ----
local MiniIcons = require('mini.icons')
MiniIcons.setup({})
MiniIcons.mock_nvim_web_devicons()

---- mini files ----
local MiniFiles = require('mini.files')
MiniFiles.setup({
    mappings = {
        go_in = 'L',
        go_in_plus = '<CR>',
        go_out = '-',
        go_out_plus = 'H',
    },
})
vim.keymap.set('n', '-', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Toggle mini file explorer' })
vim.keymap.set('n', '<leader>-', function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, { desc = 'Toggle into currently opened file' })

---- mini notify ----
-- only show messages
require('mini.notify').setup({
    content = {
        format = function(notif) return notif.msg end,
    },
})

---- mini cmdline completion ----
require('mini.cmdline').setup({ autocorrect = { enable = true } })

---- mini surround ----
require('mini.surround').setup()
-- Default keymap
-- | `sa` | Add surrounding                 |
-- | `sd` | Delete surrounding              |
-- | `sr` | Replace surrounding             |
-- | `sf` | Find surrounding (right)        |
-- | `sF` | Find surrounding (left)         |
-- | `sh` | Highlight surrounding           |
-- | `sn` | Update n_lines                  |
-- | `l` / `n` | as suffix for prev/next    |

---- mini pick ----
local MiniPicker = require('mini.pick')
MiniPicker.setup()

vim.keymap.set('n', '<leader>pf', function() MiniPicker.builtin.files() end, { desc = 'Mini File picker' })
vim.keymap.set(
    'n',
    '<leader>ps',
    function() MiniPicker.builtin.grep({ pattern = vim.fn.expand('<cword>') }) end,
    { desc = 'Mini Grep picker' }
)
vim.keymap.set('n', '<leader>vh', function() MiniPicker.builtin.help() end, { desc = 'Mini Help' })

---- mini extra ----
local MiniExtra = require('mini.extra')
MiniExtra.setup()
vim.keymap.set('n', '<leader>xx', function() MiniExtra.pickers.diagnostic() end, { desc = 'Mini Picker' })

vim.keymap.set('n', '<leader>pk', function() MiniExtra.pickers.keymaps() end, { desc = 'Search keaymaps' })

---- mini complitions ----
local MiniCompetion = require('mini.completion')
MiniCompetion.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return MiniCompetion.default_process_items(items, base, {
                filtersort = 'fuzzy',
            })
        end,
    },
})

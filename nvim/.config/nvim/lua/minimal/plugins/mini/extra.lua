---- mini extra ----
local MiniExtra = require('mini.extra')
MiniExtra.setup()
vim.keymap.set('n', '<leader>xx', function() MiniExtra.pickers.diagnostic() end, { desc = 'Mini Picker' })

vim.keymap.set('n', '<leader>pk', function() MiniExtra.pickers.keymaps() end, { desc = 'Search keaymaps' })

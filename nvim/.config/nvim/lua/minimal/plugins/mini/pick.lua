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

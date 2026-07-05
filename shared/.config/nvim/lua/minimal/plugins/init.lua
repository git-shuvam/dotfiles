-- =================================
-- Pack
-- =================================

vim.pack.add({
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    -- filetree
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3') },
    -- dependency
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',

})


require('minimal.plugins.colorscheme')
require('minimal.plugins.mason')
require('minimal.plugins.neotree')
require('minimal.plugins.lualine')
require('minimal.plugins.mini')

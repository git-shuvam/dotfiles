-- require("nvim-tree").setup({ sort = { sorter = "case_sensitive", folders_first = true }, view = { width = 30, side = 'right', cursorline = false }, renderer = { group_empty = true, }, filters = { dotfiles = false, git_ignored = false } })
-- vim.keymap.set('n', '<leader><leader>', '<CMD>NvimTreeToggle<CR>', { desc = 'Open File Explorer' })

---- neo-tree ----
require('neo-tree').setup({
    default_component_configs = { name = { trailing_slash = true, highlight_opened_files = "all" } },
    window = { position = "right" },
    filesystem = { filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = true, always_show_filters = true } },
})
vim.keymap.set('n', '<leader><leader>', "<cmd>Neotree toggle<cr>", { desc = "Toggle neotree view" })

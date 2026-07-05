---@type snacks.Config.base
local snacks = {
    explorer = { enabled = true, replace_netrw = true },
    dashboard = { enabled = true },
    picker = { enabled = true },
}

require('snacks').setup(snacks)
vim.keymap.set("n", "<leader><leader>", function()
    Snacks.explorer()
end, { desc = "Toggle Snacks Eplorer" })

-- ---- neo-tree ----
-- ---@type neotree.Config
-- local opts = {
--     add_blank_line_at_top = false,
--     enable_refresh_on_write = true,
--     default_component_configs = {
--         name = { highlight_opened_files = "all" }
--     },
--     window = {
--         position = "right"
--     },
--     filesystem = {
--         filtered_items = {
--             visible = true,
--             hide_dotfiles = false,
--             hide_gitignored = true,
--             always_show_filters = true
--         }
--     },
-- }
-- require('neo-tree').setup(opts)
--
--
-- vim.keymap.set('n', '<leader><leader>', "<cmd>Neotree toggle<cr>", { desc = "Toggle neotree view" })

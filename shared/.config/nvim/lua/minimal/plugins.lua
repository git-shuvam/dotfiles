vim.pack.add({
  -- ColorTheme
  "https://github.com/folke/tokyonight.nvim",

  -- Lsp
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/stevearc/conform.nvim",

  -- misc
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-mini/mini.nvim",

  -- UI
  "https://github.com/folke/snacks.nvim",
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",

  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
--[[
==================================================================
ColorScheme
==================================================================
]]

vim.cmd([[colorscheme tokyonight-night]])

--[[
==================================================================
LSP
==================================================================
]]

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "emmet_ls", "html", "just", "ruff", "rust_analyzer", "ts_ls" },
})
require("mason-tool-installer").setup({
  auto_update = true,
  ensure_installed = { "stylua", "prettier", "shfmt", "ty" },
})
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    python = { "ruff" },
    lua = { "stylua" },
  },
  -- This built-in option handles format-on-save properly without an extra autocmd
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
  formatters = {
    prettier = {
      -- CRITICAL: Fix arguments to pass correctly to the Prettier CLI execution array
      prepend_args = {
        "--stdin-filepath",
        "$FILENAME",
        "--config",
        vim.fn.expand("~") .. "/.config/.prettierrc",
      },
    },
  },
})

vim.keymap.set(
  { "n", "v" },
  "<leader>f",
  function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end,
  { desc = "Format file or selection" }
)

--[[
==================================================================
FileTree
==================================================================
]]

-- Simple script to pipe LSP loading notifications into Snacks
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        -- Show checkmark if finished, otherwise render the spinning frames
        notif.icon = ev.data.params.value.kind == "end" and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

---@type snacks.Config.base
local snacks = {
  ---@class snacks.explorer.Config
  explorer = { enabled = true, replace_netrw = true },

  ---@class snacks.picker.Config
  picker = {
    enabled = true,
    sources = {
      explorer = {
        layout = { layout = { position = "right" } },
        auto_close = true,
        hidden = true,
        ignored = true,
      },
    },
  },
  ---@class snacks.notifier.Config
  notifier = { enabled = true, style = "compact", level = vim.log.levels.DEBUG },

  ---@class snacks.dashboard.Config
  dashboard = {
    enabled = false,
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "recent_files", icon = " ", title = "Recent Files", indent = 2 },
      { section = "projects", icon = " ", title = "Projects", indent = 2 },
    },
  },
}
require("snacks").setup(snacks)
vim.keymap.set("n", "<leader><leader>", function() Snacks.explorer() end, { desc = "Toggle Snacks Eplorer" })

--[[
==================================================================
Tab Bar
==================================================================
]]

require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "thin", -- slant, slope, thick, thin
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    diagnostics = "nvim_lsp",
    close_command = function(n) Snacks.bufdelete(n) end,
    right_mouse_command = function(n) Snacks.bufdelete(n) end,
    offsets = {
      {
        filetype = "snacks_layout_box",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
  },
})

-- 3. Quick keybindings to swap tabs like a browser
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Tab" })

--[[
==================================================================
Status Bar
==================================================================
]]

require("lualine").setup({
  options = { component_separators = "", section_separators = "" },
  always_divide_middle = true,
  globalstatus = true,
  sections = {
    lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
    lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
    lualine_c = {},
    lualine_x = { "filetype" },
    lualine_y = {},
    lualine_z = { "location" },
  },
})

--[[
==================================================================
Git signs
==================================================================
]]
require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 300,
    virt_text_pos = "eol",
  },
})

--[[
==================================================================
Mini.nvim
==================================================================
]]

---- mini complitions ----
local MiniCompetion = require("mini.completion")
MiniCompetion.setup({
  lsp_completion = {
    auto_setup = true,
    process_items = function(items, base)
      return MiniCompetion.default_process_items(items, base, { filtersort = "fuzzy" })
    end,
  },
})

---- mini icons ----
local MiniIcons = require("mini.icons")
MiniIcons.setup({})
MiniIcons.mock_nvim_web_devicons()

---- mini notify ----
-- require('mini.notify').setup({
--   content = {
--     format = function(notif) return notif.msg end,
--   },
-- }) -- only show messages

--[[
==================================================================
Markdown
==================================================================
]]
require("render-markdown").setup({
  completions = { lsp = { enabled = true } },
  latex = { enabled = false },
  bullet = { enabled = true },
  checkbox = {
    enabled = true,
    position = nil,
    unchecked = { icon = " 󰄱 ", highlight = "RenderMarkdownUnchecked", scope_highlight = nil },
    checked = { icon = " 󰱒 ", highlight = "RenderMarkdownChecked", scope_highlight = nil },
  },
  html = { enabled = false, comment = { conceal = false } },
  yaml = { enabled = false },
  link = { image = "󰥶 " },
  heading = { sign = true, icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }, backgrounds = {} },
})

--[[
==================================================================
WhichKey
==================================================================
]]
vim.keymap.set(
  "n",
  "<leader>?",
  function() require("which-key").show() end,
  { desc = "Buffer Local Keymaps (which-key)" }
)

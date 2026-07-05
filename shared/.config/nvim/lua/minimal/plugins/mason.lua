---- Mason ----
require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = { 'lua_ls', 'ty', 'ruff', 'rust_analyzer' } })

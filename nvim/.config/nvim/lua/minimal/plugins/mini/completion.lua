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

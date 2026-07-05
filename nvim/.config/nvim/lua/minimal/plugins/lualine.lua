---- LuaLine ----
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

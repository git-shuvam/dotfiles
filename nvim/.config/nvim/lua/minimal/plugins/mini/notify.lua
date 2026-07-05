---- mini notify ----
-- only show messages
require('mini.notify').setup({
    content = {
        format = function(notif) return notif.msg end,
    },
})

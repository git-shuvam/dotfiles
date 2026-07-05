-- =================================
-- Command
-- =================================
-- vim.api.nvim_create_user_command("PackLock", function()
--     vim.cmd("packdel ++all")
--     vim.pack.update(nil, { force = true })
-- end, {})

vim.api.nvim_create_user_command('PackLock', function()
    local inactive = {}

    for _, plugin in ipairs(vim.pack.get()) do
        if not plugin.active then table.insert(inactive, plugin.spec.name) end
    end

    if #inactive > 0 then vim.pack.del(inactive) end

    vim.pack.update(nil, { force = true })
end, { desc = 'Remove inactive plugins and rewrite lockfile' })

vim.api.nvim_create_user_command('PackUpdate', function(opts)
    -- check if any argument is passed
    if opts.args:match('%S') then
        local plugins = vim.split(opts.args, '%s+', { trimempty = true })
        vim.pack.update(plugins) -- update only specified plugins
    else
        vim.pack.update()
    end
end, { nargs = '*', desc = 'Update all plugins or specific ones' })

local M = {}
local api = vim.api
local keymap = vim.keymap

M.config = {
    uncrustify_executable = "uncrustify",
    config_path = "uncrustify.cfg",
    mapping = "<Space>U"
}

local function preserve_and_run_command(cmd)
    local args = string.format("keepj keepp exe %q", cmd)
    local line, col = unpack(api.nvim_win_get_cursor(0))
    api.nvim_command(cmd)

    if (vim.v.shell_error > 0) then
        print("Uncrustify error code: " .. vim.v.shell_error)
        vim.cmd [[ normal u]]
    end

    local lastline = vim.fn.line("$")
    if line > lastline then
        line = lastline
    end
    api.nvim_win_set_cursor(0, { line, col })
end

function M.run_uncrustify()
    print("Run Uncrustify" .. M.config.config_path)
    local exec = M.config.uncrustify_executable
    local config = M.config.config_path
    local command = string.format(":silent exec \"%%!%s -q -l -c %s\"", exec, config)

    preserve_and_run_command(command)
end

function M.setup(args)
    if args then
        M.config = vim.tbl_deep_extend('force', M.config, args)
    end
    keymap.set('n', M.config.mapping, M.run_uncrustify, {desc = 'Run Uncrustify', remap = false})
end

api.nvim_create_user_command(
    'Uncrustify',
    M.run_uncrustify,
    {bang = true, desc = 'Run uncrustify on the current buffer'}
    )

return M

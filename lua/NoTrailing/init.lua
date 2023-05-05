--
local config = {
    highlight = "Search",
    pattern = "\\s\\+$",
    exclude_filetypes = {
        "Telescope",
        "help",
        "lazy",
        "packer",
        "dashboard",
        "NvimTree",
        "Trouble"
    },
}

local M = {}

M.trim = function()
    -- check if current filetype is in exclude_filetypes table
    if vim.tbl_contains(config.exclude_filetypes, vim.bo.filetype) then
        return
    end

    -- get current buffer
    local buf = vim.api.nvim_get_current_buf()
    -- get all lines in buffer
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    --  counter for trimmed lines. This is used for the message
    local count = 0

    for i, line in ipairs(lines) do
        -- find for trailing whitespace in each line
        local match = string.find(line, "%s+$")
        if match then
            lines[i] = string.gsub(line, "%s+$", "")
            -- count how many lines were trimmed
            count = count + 1
        end
    end

    -- replace all lines in the buffer with the trimmed lines
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    -- print message
    print("Removed trailing whitespace on " .. count .. " line(s)")
end

M.highlight = function()
    -- check if current filetype is in exclude_filetypes table
    if vim.tbl_contains(config.exclude_filetypes, vim.bo.filetype) then
        return
    end

    -- check if highlight match already exists
    -- this is used by the toggle feature
    local matches = vim.fn.getmatches()
    for _, match in ipairs(matches) do
        if (match.group == config.highlight and match.pattern == config.pattern) then
            vim.fn.matchdelete(match.id)
            return
        end
    end

    -- match trailing whitespace for highlighting
    vim.fn.matchadd(config.highlight, config.pattern)
end

M.setup = function(user_config)
    -- merge user config with default config
    config = vim.tbl_extend("force", config, user_config or {})
    -- create commands
    vim.api.nvim_create_user_command("TrailingTrim", M.trim, {})
    vim.api.nvim_create_user_command("TrailingHighlightToggle", M.highlight, {})
end

return M

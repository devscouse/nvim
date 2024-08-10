local popup = require("plenary.popup")


local grid = {}
local opts = { width = 80, height = 80 }
local M = {}

local function create_window()
    local buf = vim.api.nvim_create_buf(false, false)
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    local window_id, window = popup.create(buf, {
        title = "Game Of Life",
        width = opts.width,
        height = opts.height,
        borderchars = borderchars,
    })

    return { buf = buf, window_id = window_id }
end


local function init_grid()
    for i = 1, opts.height do
        grid[i] = "hello world"
    end
end


function M.start()
    local window_info = create_window()
    WindowId = window_info.window_id
    Buf = window_info.buf
    init_grid()
    print(grid)
    print(#grid)
    vim.api.nvim_buf_set_lines(Buf, 0, #grid, false, grid)
    vim.api.nvim_buf_set_option(Buf, "buftype", "acwrite")
    vim.api.nvim_buf_set_option(Buf, "bufhidden", "delete")
    return M
end

function M.stop()
    vim.api.nvim_win_close(WindowId, true)
    WindowId = nil
end

return M

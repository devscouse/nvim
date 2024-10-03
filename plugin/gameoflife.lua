local popup = require("plenary.popup")
local grid = {}
local opts = { width = 40, height = 40 } -- Reduced size for visibility
local M = {}
local WindowId, Buf

local function create_window()
    local buf = vim.api.nvim_create_buf(false, true)
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local win_width = opts.width * 2 - 1 -- Account for spaces and border
    local win_height = opts.height       -- Account for border
    local window_id, _ = popup.create(buf, {
        title = "Game Of Life",
        line = math.floor(((vim.o.lines - win_height) / 2) - 1),
        col = math.floor((vim.o.columns - win_width) / 2),
        minwidth = win_width,
        minheight = win_height,
        maxwidth = win_width,
        maxheight = win_height,
        borderchars = borderchars,
    })
    return { buf = buf, window_id = window_id }
end


local function get_index(row, col)
    local index = (row - 1) * opts.width + col
    return index
end


local function get_grid_value(row, col)
    local index = get_index(row, col)
    if index < 1 or index > #grid then return 0 end
    return grid[index]
end


local function set_grid_value(row, col, val)
    grid[get_index(row, col)] = val
end


local function init_grid()
    for i = 1, opts.height * opts.width do
        grid[i] = math.random(0, 1) * math.random(0, 1)
    end
end


local function count_neighbours(row, col)
    local count = 0
    for row_offset = -1, 1 do
        for col_offset = -1, 1 do
            if row_offset == 0 and col_offset == 0 then
                goto continue
            end
            local cell = get_grid_value(row + row_offset, col + col_offset)
            count = count + cell
            ::continue::
        end
    end

    return count
end

local function update_grid()
    for i = 1, opts.height do
        for j = 1, opts.width do
            local n = count_neighbours(i, j)
            if n < 2 then set_grid_value(i, j, 0) end
            if n > 3 then set_grid_value(i, j, 0) end
            if n == 3 then set_grid_value(i, j, 1) end
        end
    end
end

local function grid_to_lines()
    local lines = {}
    for i = 1, opts.height do
        local line = ""
        for j = 1, opts.width do
            local index = get_index(i, j)
            local cell = " "
            if grid[index] > 0 then cell = "X" end
            line = line .. cell .. " "
        end
        table.insert(lines, line:sub(1, -2)) -- Remove trailing space
    end
    return lines
end

local function display_grid()
    vim.api.nvim_buf_set_option(Buf, 'modifiable', true)
    vim.api.nvim_buf_set_lines(Buf, 0, -1, false, grid_to_lines())
    vim.api.nvim_buf_set_option(Buf, 'modifiable', false)
end

function M.start()
    local window_info = create_window()
    WindowId = window_info.window_id
    Buf = window_info.buf
    init_grid()
    Timer = vim.loop.new_timer()
    Timer:start(0, 50, vim.schedule_wrap(function()
        display_grid()
        update_grid()
    end))
    display_grid()
    return M
end

function M.stop()
    if Timer then
        Timer:stop()
        Timer:close()
        Timer = nil
    end
    if WindowId and vim.api.nvim_win_is_valid(WindowId) then
        vim.api.nvim_win_close(WindowId, true)
        WindowId = nil
    end
end

return M

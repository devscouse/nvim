local path = require('plenary.path')
local popup = require('plenary.popup')
local data = vim.fn.stdpath('data')
local todo_data = string.format("%s/todo", data)
local todo_text = string.format("%s/todo.txt", todo_data)
local M = {}
local opts = { height = 40, width = 40 }

TodoLines = nil
WindowId = nil
Buf = nil

local function split_lines(inputstr)
    local sep = "\n"
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end


local function read_todo_data()
    local content = path:new(todo_text):read()
    local lines = split_lines(content)
    return lines
end

local function save_todo_list()
    if Buf == nil then return end

    TodoLines = vim.api.nvim_buf_get_lines(Buf, 0, -1, false)
    local content = ""
    for i = 1, #TodoLines do
        content = content .. TodoLines[i] .. "\n"
    end
    path.new(todo_text):write(content, "w")
end

local function _init_buffer()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, "todo-list")
    vim.api.nvim_buf_set_option(buf, "filetype", "todo")
    vim.api.nvim_buf_set_lines(buf, 0, #TodoLines, false, TodoLines)
    return buf
end

local function _init_window()
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local win_width = opts.width * 2 - 1 -- Account for spaces and border
    local win_height = opts.height       -- Account for border
    local window_id, _ = popup.create(Buf, {
        title = "To Do List",
        line = math.floor(((vim.o.lines - win_height) / 2) - 1),
        col = math.floor((vim.o.columns - win_width) / 2),
        minwidth = win_width,
        minheight = win_height,
        borderchars = borderchars,
    })
    return window_id
end

local function open()
    if TodoLines == nil then
        TodoLines = read_todo_data()
    end
    if Buf == nil then
        Buf = _init_buffer()
    end
    if WindowId == nil or vim.api.nvim_win_is_valid(WindowId) then
        WindowId = _init_window()
    end
end

local function close()
    vim.api.nvim_win_close(WindowId, true)
    WindowId = nil

    save_todo_list()
    vim.api.nvim_buf_delete(Buf, {})
    Buf = nil
end

local function window_is_open()
    return WindowId ~= nil and vim.api.nvim_win_is_valid(WindowId)
end

function M.toggle_todo_list()
    if window_is_open() then
        close()
    else
        open()
    end
end

local devscouse_todo = vim.api.nvim_create_augroup("DevScouse_ToDo", { clear = true })
vim.keymap.set('n', '<leader>td', function() require('plugin.todo').toggle_todo_list() end,
    { desc = "Toggle [T]o [D]o List" })

return M

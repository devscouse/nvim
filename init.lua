require("devscouse")

-- Use a python3 virtual environment just for neovim
local cfg_path = vim.fn.stdpath("config")
vim.g.python3_host_prog = cfg_path .. "/pyvim3/bin/python.exe"

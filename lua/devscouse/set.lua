vim.opt.guicursor = ""
vim.g.have_nerd_font = true
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netr_winsize = 25

-- Show the mode (e.g. insert)
vim.opt.showmode = true

-- Turn on line numbers and make them relative
vim.opt.nu = true
vim.opt.relativenumber = true

-- Set indenting configuration
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Set whether text should wrap or not
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- Set whether a search term should remain highlighted
vim.opt.hlsearch = false

-- Highlight search results as you are typing
vim.opt.incsearch = true

-- Case-insensitive searching unless capital letters are used in the search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Mark column 80 in a different colour
vim.opt.colorcolumn = "80"

-- Save undo history
vim.opt.undofile = true

-- terminal settings
local powershell_options = {
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
}

if not vim.fn.has('macunix') then
    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end


-- Set python indent levels
vim.g.python_indent = {
    disable_parenthesis_indenting = false,
    closed_paren_align_last_line = false,
    searchpair_timeout = 150,
    continue = 'shiftwidth()',
    open_paren = 'shiftwidth()',
    nested_paren = 'shiftwidth()',
}

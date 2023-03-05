-- Use system clipboard
vim.opt.clipboard = "unnamedplus"


-- Interface stuff
vim.opt.cursorline = true -- Highlight current line
vim.opt.ruler = true -- always show current pos
vim.opt.background = 'dark' -- dark bg
vim.opt.signcolumn = 'yes'

vim.o.termguicolors = true
vim.cmd.colorscheme("catppuccin-frappe")

vim.opt.number = true

-- Search
vim.opt.hlsearch = true -- highlight
vim.opt.smartcase = true -- be smart about cases
vim.opt.incsearch = true -- make search act like in browsers
vim.opt.magic = true -- for better regexes

-- Text, editing
vim.opt.backspace = [[indent,eol,start]]
vim.opt.wrap = true
vim.opt.scrolloff = 999 -- cursor in the middle of the screen

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2

-- highlight matching parenthesis
vim.opt.showmatch = true

-- Mappings
local map = vim.api.nvim_set_keymap

-- Move through splits
map('n', '<C-k>', '<C-w><C-k>', { noremap = true, silent = false })
map('n', '<C-l>', '<C-w><C-l>', { noremap = true, silent = false })
map('n', '<C-j>', '<C-w><C-j>', { noremap = true, silent = false })
map('n', '<C-h>', '<C-w><C-h>', { noremap = true, silent = false })

-- Cycle through buffers
map('n', '<C-n>', ':bnext<CR>', { noremap = true, silent = false })
map('n', '<C-p>', ':bprevious<CR>', { noremap = true, silent = false })

-- Ensure we strip whitespace on save and configure the highlight color
vim.g.better_whitespace_enabled = true
vim.g.strip_whitespace_on_save = true
vim.g.strip_whitespace_confirm = false
vim.g.better_whitespace_guicolor = require("catppuccin.palettes").get_palette("frappe").red;
vim.cmd('command! FixWhitespace StripWhitespace')

vim.o.termguicolors = true
-- Must be set before the colorscheme loads: vim-better-whitespace reads it in
-- its ColorScheme autocmd.
vim.g.better_whitespace_guicolor = require("catppuccin.palettes").get_palette("frappe").red
vim.cmd.colorscheme("catppuccin-frappe")

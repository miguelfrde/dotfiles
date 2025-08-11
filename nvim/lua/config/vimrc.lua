-- Use , as the <Leader>
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Interface stuff
vim.opt.cursorline = true   -- Highlight current line
vim.opt.colorcolumn = "80,100";
vim.opt.ruler = true        -- always show current pos
vim.opt.background = 'dark' -- dark bg
vim.opt.signcolumn = 'yes'

vim.opt.number = true

-- Search
vim.opt.hlsearch = true  -- highlight
vim.opt.smartcase = true -- be smart about cases
vim.opt.incsearch = true -- make search act like in browsers
vim.opt.magic = true     -- for better regexes

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
vim.cmd('command! FixWhitespace StripWhitespace')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-i>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

require("mason").setup()
local lsps = {
  "bashls",
  "clangd",
  "cssls",
  "html",
  "jsonls",
  "lua_ls",
  "rust_analyzer",
  "pyright",
  "marksman", -- markdown
  "sqlls",
  "taplo", -- toml
  "tsserver",
  "yamlls",
}
require("mason-lspconfig").setup({
  ensure_installed = lsps
})

require("nvim-tree").setup()
require("lualine").setup()
require("nvim-tmux-navigation").setup({
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    last_active = "<C-\\>",
    next = "<C-Space>",
  }
})

local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "buffer" },
    { name = "calc" },
    { name = "luasnip" },
    { name = "nvim_lua",               keyword_length = 2 },
    { name = "nvim_lsp",               keyword_length = 3 },
    { name = "nvim_lsp_signature_help" },
    { name = "path" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-S-f>"] = cmp.mapping.scroll_docs( -4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

local capabilities = require("cmp_nvim_lsp").default_capabilities();
local lspconfig = require("lspconfig");

for _, lsp in pairs(lsps) do
  if lsp == "lua_ls" then
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "rt" }
          }
        }
      }
    })
  elseif lsp == "rust_analyzer" then
    -- SKIP. rust-tools configures it for us.
  else
    lspconfig[lsp].setup({
      capabilities = capabilities,
    })
  end
end

local rt = require("rust-tools");
rt.setup({
  tools = {
    runnables = {
      use_telescope = true
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    }
  },
  capabilities = capabilities,
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
})

rt.inlay_hints.enable()

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "cpp",
    "css",
    "dart",
    "gitignore",
    "html",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown",
    "proto",
    "regex",
    "rust",
    "sql",
    "typescript",
    "toml",
    "yaml"
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
})

require('gitsigns').setup({
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
  end
})

require("fidget").setup()

require("virt-column").setup()

require("todo-comments").setup()

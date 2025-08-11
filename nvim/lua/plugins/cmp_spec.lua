return {
  -- Completion framework
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- LSP completion source
      "hrsh7th/cmp-nvim-lsp",
      -- Completion for buffer words
      "hrsh7th/cmp-buffer",
      -- Completion for filesystem paths
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "calc" },
          { name = "luasnip" },
          { name = "nvim_lua",               keyword_length = 2 },
          { name = "nvim_lsp",               keyword_length = 3 },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Add tab support
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
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
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
      }
    end
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = {},
  },
}

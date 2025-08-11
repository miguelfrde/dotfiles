return {
  -- Install and manage LSP servers, debuggers, linters
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- LSP support
  { "neovim/nvim-lspconfig" },

  -- Rust analyzer utils
  {
    "mrcjkb/rustaceanvim",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    version = "^6",
    lazy = false, -- This plugin is already lazy
    tools = {
      runnables = {
        use_telescope = true,
      }
    },
    server = {
      on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>ca", function()
          vim.cmd.RustLsp("codeAction")
        end, { silent = true, buffer = bufnr })

        -- Override Neovim"s built-in hover keymap with rustaceanvim"s hover actions
        vim.keymap.set("n", "K", function()
          vim.cmd.RustLsp({"hover", "actions"})
        end, { silent = true, buffer = bufnr })

      end,
      default_settings = {
        ["rust-analyzer"] = {
          -- clippy on save
          checkOnSave = diagnostics == "rust-analyzer",
        },
        diagnostics = {
          enable = diagnostics == "rust-analyzer",
        },
      },
      procMacro = {
        enable = true,
        ignored = {
          --["async-trait"] = { "async_trait" },
        }
      },
      files = {
        excludeDirs = {
          ".direnv",
          ".git",
          ".github",
          ".gitlab",
          "bin",
          "node_modules",
          "target",
          "venv",
          ".venv",
        },
      },
    }
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}

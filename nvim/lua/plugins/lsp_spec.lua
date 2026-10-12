return {
  -- Install and manage LSP servers, debuggers, linters
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- LSP support. Server definitions come from nvim-lspconfig's lsp/ directory;
  -- on Neovim 0.11+ each one must be enabled explicitly.
  -- lua-language-server itself is installed via packages/Brewfile.
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("lua_ls")
    end,
  },

  -- Rust analyzer utils. rust-analyzer comes from rustup.
  -- rustaceanvim reads vim.g.rustaceanvim (not lazy.nvim spec keys), so it is
  -- set in `init`, which runs before the plugin loads.
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>ca", function()
              vim.cmd.RustLsp("codeAction")
            end, { silent = true, buffer = bufnr })

            -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
            vim.keymap.set("n", "K", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, { silent = true, buffer = bufnr })
          end,
          default_settings = {
            -- clippy on save is already the default: rustaceanvim sets
            -- check.command = "clippy" whenever cargo-clippy is on PATH.
            ["rust-analyzer"] = {
              procMacro = {
                enable = true,
                -- An empty Lua table serializes as a JSON array, which
                -- rust-analyzer rejects for this map, so only set it when needed:
                -- ignored = { ["async-trait"] = { "async_trait" } },
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
            },
          },
        },
      }
    end,
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

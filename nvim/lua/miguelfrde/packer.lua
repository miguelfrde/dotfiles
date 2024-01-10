-- Automatically bootstrap packer on a new machine.
--
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run packer compile when this file changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- Completion framework:
  use "hrsh7th/nvim-cmp"

  -- LSP completion source:
  use "hrsh7th/cmp-nvim-lsp"

  use {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      -- Install and manage LSP servers, debuggers, linters
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Automatically setup LSP config for rust-analyzer
      { "simrat39/rust-tools.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    }
  }

  use "akinsho/flutter-tools.nvim"


  -- Highlight and remove trailing whitespace
  use "ntpeters/vim-better-whitespace"

  -- Incremental parsing
  use "nvim-treesitter/nvim-treesitter"

  -- Auto close brackets
  use "rstacruz/vim-closer"

  -- Fuzzy finder over lists
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.1",
    requires = { { "nvim-lua/plenary.nvim" } }
  }

  -- File tree explorer
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
  }

  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  }

  -- Nice theme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Navigation in tmux
  use { "alexghergh/nvim-tmux-navigation" }

  -- Git signs and status bar
  use "lewis6991/gitsigns.nvim"
  -- Git utils
  use "tpope/vim-fugitive"

  -- Fidget: to see rust-analyzer progress.
  use {
    "j-hui/fidget.nvim",
    tag = "legacy",
  }

  -- Thinner column markers than vim"s colorcolumn
  use "lukas-reineke/virt-column.nvim"

  -- Hilight TODO comments
  use "folke/todo-comments.nvim"

  -- Leave these after all plugins.
  if packer_bootstrap then
    require("packer").sync()
  end
end)

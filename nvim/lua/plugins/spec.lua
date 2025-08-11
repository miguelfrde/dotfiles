return {
  -- Navigation with tmux panes
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      }
    }
  },

  -- Nice status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    }
  },

  -- Nice theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Highlight and remove trailing whitespace
  { "ntpeters/vim-better-whitespace" },

  -- Git signs and status bar
  { "lewis6991/gitsigns.nvim" },

  -- Git utils
  { "tpope/vim-fugitive" },

  -- Thinner column markers than vim"s colorcolumn
  { "lukas-reineke/virt-column.nvim", opts = {}},

  -- Hilight TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },

  -- Auto close brackets
  { "rstacruz/vim-closer" },

  -- Fidget: to see rust-analyzer progress.
  { "j-hui/fidget.nvim", opts = {}},

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
}

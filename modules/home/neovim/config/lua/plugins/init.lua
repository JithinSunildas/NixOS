-- ~/nix-config/modules/home/neovim/config/lua/plugins/init.lua

return {
  -- LSP & Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "neovim/nvim-lspconfig",
  },

  -- Telescope
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-lua/plenary.nvim",

  -- Find and Replace
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },

  -- File Explorer
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",

  -- UI
  "nvim-lualine/lualine.nvim",
  "akinsho/bufferline.nvim",
  "goolord/alpha-nvim",
  "lukas-reineke/indent-blankline.nvim",
  "NvChad/nvim-colorizer.lua",
  "karb94/neoscroll.nvim",
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000
  },

  -- Git
  "lewis6991/gitsigns.nvim",

  -- Utilities
  "windwp/nvim-autopairs",
  "numToStr/Comment.nvim",
  "folke/which-key.nvim",

  -- Extra plugins
  "nvim-flutter/flutter-tools.nvim",
  "ahmedkhalf/project.nvim",
  "folke/flash.nvim",
  "j-hui/fidget.nvim",
  "echasnovski/mini.surround",
  "abecodes/tabout.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "mg979/vim-visual-multi",
    lazy = false
  }
}

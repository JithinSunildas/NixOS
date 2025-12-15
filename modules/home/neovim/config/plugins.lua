-- modules/home/neovim/config/plugins.lua

return {
  -- === 1. UI & Navigation (You already have this) ===
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = "NvimTreeToggle",
    -- Optional config:
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" } },
  },

  -- === 2. Language Server Protocol (LSP) ===
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    dependencies = {
      -- 2a. Automatic LSP installer
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      
      -- 2b. The actual completion engine (see next section)
      "hrsh7th/nvim-cmp",
    },
  },

  -- === 3. Autocompletion & Snippets (The engine behind LSP) ===
  {
    "hrsh7th/nvim-cmp", -- Autocompletion engine
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- Source: LSP
      "hrsh7th/cmp-buffer",    -- Source: Current buffer words
      "hrsh7th/cmp-path",      -- Source: File paths
      
      -- Snippet support (Essential for modern editing)
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip", -- Connects Luasnip to nvim-cmp
    },
    config = function()
      -- Configuration to set up the completion sources and keymaps (e.g., Tab to select)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        }),
        -- Add keymaps like <C-Space> to trigger completion
      })
    end,
  },
  
  -- === 4. Fuzzy Finder (Telescope is the standard) ===
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Utility functions
      -- Add extensions like: 'nvim-telescope/telescope-fzf-native.nvim' for speed
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
  },

  -- === 5. Syntax & Text Objects ===
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "rust", "haskell", "java", "nix", "lua" }, -- I added your favorites!
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  
  -- Treesitter-based text objects (essential for quick editing)
  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
  
  -- === 6. The Status/Tabline (Lualine is highly flexible) ===
  {
    "nvim-lualine/lualine.nvim",
    opts = { options = { theme = "auto" } },
  },
}

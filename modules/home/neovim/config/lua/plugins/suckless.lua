-- ~/nix-config/modules/home/neovim/config/lua/plugins/init.lua

return {
    -- LSP & Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
    },

    -- Telescope
    "nvim-telescope/telescope.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/plenary.nvim",

    -- UI
    -- "webhooked/kanso.nvim
    -- "rebelot/kanagawa.nvim",
    -- {
    --     "sainnhe/everforest",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.o.background = "dark"
    --         vim.g.everforest_better_performance = 1
    --         vim.g.everforest_background = 'hard'
    --         vim.g.everforest_enable_italic = true
    --         vim.cmd.colorscheme("everforest")
    --     end,
    -- },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.o.background = "dark"
            -- vim.g.everforest_better_performance = 1
            -- vim.g.everforest_background = 'hard'
            -- vim.g.everforest_enable_italic = true
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },
    -- {
    --     "sainnhe/gruvbox-material",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.o.background = "dark"
    --         vim.g.gruvbox_material_background = 'hard'
    --         vim.g.gruvbox_material_foreground = 'material'
    --         vim.g.gruvbox_material_better_performance = 1
    --         vim.cmd.colorscheme("gruvbox-material")
    --     end,
    -- },

    -- Git
    "lewis6991/gitsigns.nvim",

    -- Utilities
    -- "folke/flash.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-autopairs",
}

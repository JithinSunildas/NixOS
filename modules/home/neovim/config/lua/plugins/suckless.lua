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
    {
        "neovim/nvim-lspconfig",
    },

    -- Telescope
    "nvim-telescope/telescope.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/plenary.nvim",

    -- UI
    {
        -- "webhooked/kanso.nvim
        -- "rebelot/kanagawa.nvim",
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'material'
            vim.g.gruvbox_material_better_performance = 1

            vim.cmd.colorscheme("gruvbox-material")
        end,

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "gruvbox-material",
            callback = function()
                local hl = vim.api.nvim_set_hl

                -- ERROR: Dragon Red (Punchy)
                hl(0, "DiagnosticError", { fg = "#E82424", bold = true })
                hl(0, "DiagnosticSignError", { fg = "#E82424" })

                -- WARN: Gruvbox Orange (Distinct from Error)
                hl(0, "DiagnosticWarn", { fg = "#fe8019", bold = true })
                hl(0, "DiagnosticSignWarn", { fg = "#fe8019" })

                -- INFO: Gruvbox Blue (Cool & calm)
                hl(0, "DiagnosticInfo", { fg = "#83a598" })
                hl(0, "DiagnosticSignInfo", { fg = "#83a598" })

                -- HINT: Gruvbox Aqua/Green (Subtle but different)
                hl(0, "DiagnosticHint", { fg = "#8ec07c" })
                hl(0, "DiagnosticSignHint", { fg = "#8ec07c" })

                -- Force the virtual text (inline hints) to use these colors too
                hl(0, "DiagnosticVirtualTextError", { fg = "#E82424", bg = "#3c1f1f" })
                hl(0, "DiagnosticVirtualTextWarn", { fg = "#fe8019", bg = "#332b1a" })
                hl(0, "DiagnosticVirtualTextInfo", { fg = "#83a598", bg = "#1d2b33" })
                hl(0, "DiagnosticVirtualTextHint", { fg = "#8ec07c", bg = "#1e2b26" })
            end,
        })
    },

    -- Git
    "lewis6991/gitsigns.nvim",

    -- Utilities
    -- "folke/flash.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-autopairs",
}

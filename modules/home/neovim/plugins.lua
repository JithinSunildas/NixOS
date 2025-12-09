-- modules/home/neovim/plugins.lua

local plugins = {

	-- === Core & Utility ===

	-- Icons
	{ "nvim-tree/nvim-web-devicons" },

	-- Treesitter (Managed by Nix, but still required for configuration)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		enabled = false, -- Nix provides the plugin itself.
	},

	-- Lazy-loaded plugin dependencies
	{ "nvim-lua/plenary.nvim" },

	-- === UI & Navigation ===

	-- Buffer line (tabs)
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Which-key for keybinding hints
	{ "folke/which-key.nvim", event = "VeryLazy" },

	-- Smooth scrolling
	{ "karb94/neoscroll.nvim", event = "VeryLazy" },

	-- Colorize color codes
	{ "norcalli/nvim-colorizer.lua", event = "BufReadPre" },

	-- Highlight yanked text
	{ "machakann/vim-highlightedyank", event = "VeryLazy" },

	-- === LSP, Completion & Linting ===

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
	},

	-- Formatting with conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},

	-- Linting with nvim-lint
	{ "mfussenegger/nvim-lint", event = { "BufReadPre", "BufNewFile" } },

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},

	-- === Tools & Workflow ===

	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	-- Clipboard manager with history (Resolves the 'neoclip' error by ensuring its presence)
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = { "nvim-telescope/telescope.nvim" },
		event = "VeryLazy",
	},

	-- Git signs
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" } },

	-- Auto pairs
	{ "windwp/nvim-autopairs", event = "InsertEnter" },

	-- Comment
	{ "numToStr/Comment.nvim" },

	-- Flutter tools
	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Rust tools
	{ "simrat39/rust-tools.nvim", ft = "rust" },

	-- Session management
	{ "folke/persistence.nvim", event = "BufReadPre" },

	-- Project management
	{ "ahmedkhalf/project.nvim", event = "VeryLazy" },

	-- Better escape
	{ "max397574/better-escape.nvim", event = "InsertEnter" },

	-- Window/Pane management
	{ "mrjones2014/smart-splits.nvim", lazy = false },

	-- Split/Pane creation helpers
	{ "folke/edgy.nvim", event = "VeryLazy" },
}

return plugins

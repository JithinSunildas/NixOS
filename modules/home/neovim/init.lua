-- modules/neovim/init.lua
-- Basic settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
	-- Icons (required for many plugins)
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {}, -- Managed by Nix
				auto_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Use new vim.lsp.config API (Neovim 0.11+)
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Common on_attach function for keymaps
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set(
					"n",
					"gd",
					vim.lsp.buf.definition,
					vim.tbl_extend("force", opts, { desc = "Go to definition" })
				)
				vim.keymap.set(
					"n",
					"gD",
					vim.lsp.buf.declaration,
					vim.tbl_extend("force", opts, { desc = "Go to declaration" })
				)
				vim.keymap.set(
					"n",
					"gi",
					vim.lsp.buf.implementation,
					vim.tbl_extend("force", opts, { desc = "Go to implementation" })
				)
				vim.keymap.set(
					"n",
					"gr",
					vim.lsp.buf.references,
					vim.tbl_extend("force", opts, { desc = "Show references" })
				)
				vim.keymap.set(
					"n",
					"K",
					vim.lsp.buf.hover,
					vim.tbl_extend("force", opts, { desc = "Hover documentation" })
				)
				vim.keymap.set(
					"n",
					"<leader>rn",
					vim.lsp.buf.rename,
					vim.tbl_extend("force", opts, { desc = "Rename symbol" })
				)
				vim.keymap.set(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Code action" })
				)
				vim.keymap.set(
					"n",
					"[d",
					vim.diagnostic.goto_prev,
					vim.tbl_extend("force", opts, { desc = "Previous diagnostic" })
				)
				vim.keymap.set(
					"n",
					"]d",
					vim.diagnostic.goto_next,
					vim.tbl_extend("force", opts, { desc = "Next diagnostic" })
				)
				vim.keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					vim.tbl_extend("force", opts, { desc = "Show diagnostic" })
				)
			end

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = { command = "clippy" },
					},
				},
			})

			-- Dart/Flutter
			lspconfig.dartls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- PHP/Laravel
			lspconfig.phpactor.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- TypeScript/JavaScript
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Java
			lspconfig.jdtls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- C/C++
			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.cmake.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Verilog/SystemVerilog
			lspconfig.verible.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			-- Nix
			lspconfig.nixd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},

	-- Formatting with conform.nvim
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					-- Rust
					rust = { "rustfmt" },

					-- Dart/Flutter
					dart = { "dart_format" },

					-- PHP/Laravel
					php = { "php_cs_fixer" },

					-- JavaScript/TypeScript/JSON/HTML/CSS
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },

					-- Python
					python = { "black", "isort" },

					-- Java
					java = { "google-java-format" },

					-- C/C++
					c = { "clang_format" },
					cpp = { "clang_format" },
					cmake = { "cmake_format" },

					-- Verilog
					verilog = { "verible" },
					systemverilog = { "verible" },

					-- Lua
					lua = { "stylua" },

					-- Nix
					nix = { "nixfmt" },
				},

				-- Format on save
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},

				formatters = {
					php_cs_fixer = {
						command = "php-cs-fixer",
						args = { "fix", "$FILENAME" },
					},
					verible = {
						command = "verible-verilog-format",
					},
					nixfmt = {
						command = "nixfmt",
					},
				},
			})
		end,
	},

	-- Linting with nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint" },
				typescript = { "eslint" },
				javascriptreact = { "eslint" },
				typescriptreact = { "eslint" },
				python = { "ruff" },
				php = { "phpstan" },
				nix = { "statix" },
			}

			-- Auto-lint on save and text change
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

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
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			-- File pickers
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fa", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find All Files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

			-- Search
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word" },
			{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },

			-- Git
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },

			-- LSP
			{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
			{ "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
			{ "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },

			-- Other
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					prompt_prefix = "🔍 ",
					selection_caret = "➜ ",
					path_display = { "truncate" },
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<esc>"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
					},
				},
			})

			-- Load extensions
			telescope.load_extension("fzf")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
		},
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 35,
				},
				renderer = {
					group_empty = true,
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
					},
				},
				filters = {
					dotfiles = false,
				},
			})
		end,
	},

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Previous hunk" })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
					map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, { desc = "Blame line" })
				end,
			})
		end,
	},

	-- Auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "Comment toggle" },
			{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
		},
		config = function()
			require("Comment").setup()
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto", -- Auto-detect from Stylix
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	-- Flutter tools
	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("flutter-tools").setup({
				lsp = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				},
			})
		end,
	},

	-- Rust tools
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		config = function()
			require("rust-tools").setup({
				server = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				},
			})
		end,
	},

	-- Which-key for keybinding hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				plugins = {
					spelling = { enabled = true },
				},
			})
		end,
	},

	-- Better escape
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = { enabled = false },
				exclude = {
					filetypes = {
						"help",
						"lazy",
						"mason",
						"notify",
						"NvimTree",
					},
				},
			})
		end,
	},

	-- Buffer line (tabs)
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			-- Tab/Buffer navigation
			{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
			{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
			{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Close Buffer" },
			{ "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers to Left" },
			{ "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers to Right" },
			{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
			{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
			{ "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to Buffer 1" },
			{ "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to Buffer 2" },
			{ "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to Buffer 3" },
			{ "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to Buffer 4" },
			{ "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to Buffer 5" },
		},
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "ordinal",
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					diagnostics = "nvim_lsp",
					always_show_bufferline = true,
					show_buffer_close_icons = true,
					show_close_icon = false,
					separator_style = "thin",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true,
						},
					},
				},
			})
		end,
	},

	-- Window/Pane management
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		keys = {
			-- Resize panes
			{ "<C-Up>", "<cmd>lua require('smart-splits').resize_up()<cr>", desc = "Resize pane up" },
			{ "<C-Down>", "<cmd>lua require('smart-splits').resize_down()<cr>", desc = "Resize pane down" },
			{ "<C-Left>", "<cmd>lua require('smart-splits').resize_left()<cr>", desc = "Resize pane left" },
			{ "<C-Right>", "<cmd>lua require('smart-splits').resize_right()<cr>", desc = "Resize pane right" },

			-- Navigate panes
			{ "<C-h>", "<cmd>lua require('smart-splits').move_cursor_left()<cr>", desc = "Move to left pane" },
			{ "<C-j>", "<cmd>lua require('smart-splits').move_cursor_down()<cr>", desc = "Move to bottom pane" },
			{ "<C-k>", "<cmd>lua require('smart-splits').move_cursor_up()<cr>", desc = "Move to top pane" },
			{ "<C-l>", "<cmd>lua require('smart-splits').move_cursor_right()<cr>", desc = "Move to right pane" },

			-- Swap panes
			{ "<leader>wh", "<cmd>lua require('smart-splits').swap_buf_left()<cr>", desc = "Swap buffer left" },
			{ "<leader>wj", "<cmd>lua require('smart-splits').swap_buf_down()<cr>", desc = "Swap buffer down" },
			{ "<leader>wk", "<cmd>lua require('smart-splits').swap_buf_up()<cr>", desc = "Swap buffer up" },
			{ "<leader>wl", "<cmd>lua require('smart-splits').swap_buf_right()<cr>", desc = "Swap buffer right" },
		},
		config = function()
			require("smart-splits").setup({
				resize_mode = {
					silent = true,
					hooks = {
						on_leave = function()
							require("bufresize").register()
						end,
					},
				},
			})
		end,
	},

	-- Split/Pane creation helpers
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>sv", "<cmd>vsplit<cr>", desc = "Split Vertically" },
			{ "<leader>sh", "<cmd>split<cr>", desc = "Split Horizontally" },
			{ "<leader>se", "<C-w>=", desc = "Equal Splits" },
			{ "<leader>sx", "<cmd>close<cr>", desc = "Close Split" },
		},
		opts = {},
	},

	-- Smooth scrolling
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function()
			require("neoscroll").setup()
		end,
	},

	-- Colorize color codes
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[  ████████╗ ██╗ ██╗  ██╗ ██╗  ██╗  █████╗  ██████╗   ██████╗  ███╗   ███╗ ]],
				[[  ╚══██╔══╝ ██║ ██║ ██╔╝ ██║  ██║ ██╔══██╗ ██╔══██╗ ██╔═══██╗ ████╗ ████║ ]],
				[[     ██║    ██║ █████╔╝  ███████║ ███████║ ██████╔╝ ██║   ██║ ██╔████╔██║ ]],
				[[     ██║    ██║ ██╔═██╗  ██╔══██║ ██╔══██║ ██╔══██╗ ██║   ██║ ██║╚██╔╝██║ ]],
				[[     ██║    ██║ ██║  ██╗ ██║  ██║ ██║  ██║ ██████╔╝ ╚██████╔╝ ██║ ╚═╝ ██║ ]],
				[[     ╚═╝    ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═════╝   ╚═════╝  ╚═╝     ╚═╝ ]],
				[[                                                                       ]],
				[[                        [ NixOS + Neovim = 🚀 ]                        ]],
				[[                                                                       ]],
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Config", ":e ~/.config/home-manager/modules/neovim/init.lua <CR>"),
				dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}

			-- Footer
			local function footer()
				local total_plugins = require("lazy").stats().count
				local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
				return datetime .. "   " .. total_plugins .. " plugins"
			end

			dashboard.section.footer.val = footer()

			alpha.setup(dashboard.opts)

			-- Disable folding on alpha buffer
			vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		end,
	},

	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
		opts = {},
	},

	-- Project management
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "pattern", "lsp" },
				patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "go.mod" },
			})
			require("telescope").load_extension("projects")
		end,
		keys = {
			{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
		},
	},

	-- Clipboard manager with history
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>fy", "<cmd>Telescope neoclip<cr>", desc = "Clipboard History" },
		},
		config = function()
			require("neoclip").setup({
				history = 1000,
				enable_persistent_history = true,
				continuous_sync = true,
				keys = {
					telescope = {
						i = {
							select = "<cr>",
							paste = "<c-p>",
							paste_behind = "<c-k>",
							replay = "<c-q>",
							delete = "<c-d>",
							custom = {},
						},
					},
				},
			})
			require("telescope").load_extension("neoclip")
		end,
	},

	-- Highlight yanked text
	{
		"machakann/vim-highlightedyank",
		event = "VeryLazy",
	},
})

-- Additional global keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- System clipboard is now default with clipboard=unnamedplus
-- So normal y, p, d all work with system clipboard!

-- Additional clipboard shortcuts for convenience
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Better window navigation (fallback if smart-splits not loaded)
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "Split horizontal" })

-- Tab management
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })

-- Quick save and quit
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit All" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

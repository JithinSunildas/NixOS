-- modules/home/neovim/config.lua

require("nvim-treesitter.configs").setup({
	ensure_installed = {}, -- Managed by Nix
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

-- === LSP Configuration ===
local lspconfig = vim.lsp.config
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, silent = true }

	-- LSP Keymaps
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
	vim.keymap.set(
		"n",
		"gi",
		vim.lsp.buf.implementation,
		vim.tbl_extend("force", opts, { desc = "Go to implementation" })
	)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
	vim.keymap.set(
		"n",
		"<leader>d",
		vim.diagnostic.open_float,
		vim.tbl_extend("force", opts, { desc = "Show diagnostic" })
	)
end

-- LSP Setup per Language
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
})
lspconfig.dartls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.phpactor.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.jdtls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.cmake.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.verible.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})
lspconfig.nixd.setup({ capabilities = capabilities, on_attach = on_attach })

-- === Formatting with conform.nvim ===
require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt" },
		dart = { "dart_format" },
		php = { "php_cs_fixer" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		python = { "black", "isort" },
		java = { "google-java-format" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		cmake = { "cmake_format" },
		verilog = { "verible" },
		systemverilog = { "verible" },
		lua = { "stylua" },
		nix = { "nixfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		php_cs_fixer = { command = "php-cs-fixer", args = { "fix", "$FILENAME" } },
		verible = { command = "verible-verilog-format" },
		nixfmt = { command = "nixfmt" },
	},
})
-- Map <leader>f to format buffer
vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- === Linting with nvim-lint ===
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

-- === Autocompletion ===
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

-- === Telescope fuzzy finder ===
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
		find_files = { theme = "dropdown", previewer = false },
	},
})
telescope.load_extension("fzf") -- Load extensions
telescope.load_extension("neoclip")
telescope.load_extension("projects")

-- === File explorer (nvim-tree) ===
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = { width = 35 },
	renderer = {
		group_empty = true,
		icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
	},
	filters = { dotfiles = false },
})
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })

-- === Git signs ===
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

-- === Other Plugin Setups ===
require("nvim-autopairs").setup()
require("Comment").setup()
require("lualine").setup({
	options = {
		theme = "auto",
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
require("flutter-tools").setup({ lsp = { capabilities = capabilities } })
require("rust-tools").setup({ server = { capabilities = capabilities } })
require("which-key").setup({ plugins = { spelling = { enabled = true } } })
require("better_escape").setup()
require("ibl").setup({
	indent = { char = "│", tab_char = "│" },
	scope = { enabled = false },
	exclude = { filetypes = { "help", "lazy", "mason", "notify", "NvimTree" } },
})
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
			{ filetype = "NvimTree", text = "File Explorer", highlight = "Directory", separator = true },
		},
	},
})
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
require("neoscroll").setup()
require("colorizer").setup()
require("alpha").setup(require("alpha.themes.dashboard").opts) -- The dashboard setup is moved inside alpha-nvim's block in init.lua for self-containment, but we require the module here.
require("persistence").setup({}) -- opts is needed for setup
require("project_nvim").setup({
	detection_methods = { "pattern", "lsp" },
	patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "go.mod" },
})
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

-- === Keymaps ===

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- System clipboard shortcuts
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Window/Split navigation (primary handled by smart-splits)
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split Horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal Splits" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close Split" })

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

-- Telescope Keymaps
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
	{ desc = "Find All Files" }
)
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find Word" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in Buffer" })
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace Symbols" })
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope vim_options<cr>", { desc = "Vim Options" })
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Find Projects" })
vim.keymap.set("n", "<leader>fy", "<cmd>Telescope neoclip<cr>", { desc = "Clipboard History" })

-- Bufferline Keymaps
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick Close Buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close Buffers to Left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", { desc = "Close Buffers to Right" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close Other Buffers" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Go to Buffer 1" })
vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Go to Buffer 2" })
vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Go to Buffer 3" })
vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Go to Buffer 4" })
vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Go to Buffer 5" })

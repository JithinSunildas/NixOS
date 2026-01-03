-- ~/.config/nvim/lua/plugins/setup.lua

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

    -- The Smart Return Key Fix:
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          -- If the menu is open AND you've highlighted something, confirm it
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          -- Otherwise, just a regular new line
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ select = false }),
    }),

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

}) -- === Telescope ===
local telescope = require("telescope")

telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "➜ ",
    path_display = { "truncate" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
})

-- Load extensions
pcall(telescope.load_extension, "fzf")

-- Telescope keymaps
local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fF", function()
  require("telescope.builtin").find_files({
    hidden = true,
  })
end, { desc = "Find Files (hidden)" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
require('telescope').load_extension('projects')
require("project_nvim").setup({
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "pubspec.yaml", "package.json", "flake.nix" },
})

require("flutter-tools").setup({
  ui = {
    border = "rounded",
    notification_style = "native",
  },
  decorations = {
    statusline = {
      device = true,
      app_version = true,
    }
  },
})

-- === NvimTree ===
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = { width = 35 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
})

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })

-- === Lualine ===
require("lualine").setup({
  options = {
    theme = "auto",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
})

-- === Bufferline ===
require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
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

-- Bufferline keymaps
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- === Gitsigns ===
require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

-- === Utilities ===
require("nvim-autopairs").setup()
require("Comment").setup()
require("which-key").setup()
require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = false },
})
require("colorizer").setup()

-- === Alpha (Dashboard) ===
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                                                   ",
  " ████████╗ ██╗ ██╗  ██╗ ██╗  ██╗  █████╗  ██████╗   ██████╗   ██████╗  ███╗   ███╗ ",
  " ╚══██╔══╝ ██║ ██║ ██╔╝ ██║  ██║ ██╔══██╗ ██╔══██╗ ██╔═══██╗ ██╔═══██╗ ████╗ ████║ ",
  "    ██║    ██║ █████╔╝  ███████║ ███████║ ██████╔╝ ██║   ██║ ██║   ██║ ██╔████╔██║ ",
  "    ██║    ██║ ██╔═██╗  ██╔══██║ ██╔══██║ ██╔══██╗ ██║   ██║ ██║   ██║ ██║╚██╔╝██║ ",
  "    ██║    ██║ ██║  ██╗ ██║  ██║ ██║  ██║ ██████╔╝ ╚██████╔╝ ╚██████╔╝ ██║ ╚═╝ ██║ ",
  "    ╚═╝    ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═════╝   ╚═════╝   ╚═════╝  ╚═╝     ╚═╝ ",
  "  \"A man who dares to waste one hour of time has not discovered the value of life.\" ",
  "                                                                   — Charles Darwin ",
  "                                                                                    ",
}

dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", "󰉋  Projects", ":Telescope projects<CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

return {}

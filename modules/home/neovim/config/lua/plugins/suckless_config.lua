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
pcall(telescope.load_extension, "fzf", "projects")

-- Telescope keymaps
local map = vim.keymap.set
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>F", function()
  require("telescope.builtin").find_files({
    hidden = true,
  })
end, { desc = "Find Files (hidden)" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>hf", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
map("n", "<leader>p", "<cmd>Telescope projects<cr>", { desc = "Recent Projects" })
map("n", "<leader>r", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })

require("project_nvim").setup({
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "pubspec.yaml", "package.json", "flake.nix" },
})

-- === Flash.nvim - Enhanced navigation and search ===
require("flash").setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = {
    multi_window = true,
    forward = true,
    wrap = true,
  },
  jump = {
    jumplist = true,
    pos = "start",
    history = false,
    register = false,
    nohlsearch = false,
  },
  label = {
    uppercase = false,
    rainbow = {
      enabled = false,
      shade = 5,
    },
  },
  modes = {
    search = { enabled = false },
    char = { enabled = true },
  },
})

-- Flash keymaps
local map = vim.keymap.set

map({ "n", "x", "o", "v" }, "<CR>", function()
  require("flash").jump()
end, { desc = "Flash" })

map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

map("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

map({ "c" }, "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- === Fidget.nvim - LSP progress UI ===
require("fidget").setup({
  progress = {
    poll_rate = 0,
    suppress_on_insert = false,
    ignore_done_already = false,
    ignore_empty_message = false,
    clear_on_detach = function(client_id)
      local client = vim.lsp.get_client_by_id(client_id)
      return client and client.name or nil
    end,
    notification_group = function(msg)
      return msg.lsp_client.name
    end,
    ignore = {},
    display = {
      render_limit = 16,
      done_ttl = 3,
      done_icon = "✔",
      done_style = "Constant",
      progress_ttl = math.huge,
      progress_icon = { pattern = "dots", period = 1 },
      progress_style = "WarningMsg",
      group_style = "Title",
      icon_style = "Question",
      priority = 30,
      skip_history = true,
      format_message = require("fidget.progress.display").default_format_message,
      format_annote = function(msg)
        return msg.title
      end,
      format_group_name = function(group)
        return tostring(group)
      end,
      overrides = {
        rust_analyzer = { name = "rust-analyzer" },
      },
    },
  },
  notification = {
    poll_rate = 10,
    filter = vim.log.levels.INFO,
    history_size = 128,
    override_vim_notify = false,
    configs = { default = require("fidget.notification").default_config },
    redirect = function(msg, level, opts)
      if opts and opts.on_open then
        return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
      end
    end,
    view = {
      stack_upwards = true,
      icon_separator = " ",
      group_separator = "---",
      group_separator_hl = "Comment",
    },
    window = {
      normal_hl = "Comment",
      winblend = 0,
      border = "none",
      zindex = 45,
      max_width = 0,
      max_height = 0,
      x_padding = 1,
      y_padding = 0,
      align = "bottom",
      relative = "editor",
    },
  },
  integration = {
    ["nvim-tree"] = {
      enable = true,
    },
  },
  logger = {
    level = vim.log.levels.WARN,
    float_precision = 0.01,
    path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
  },
})

-- === Mini.surround - Add/delete/replace surroundings ===
require("mini.surround").setup({
  custom_surroundings = nil,

  highlight_duration = 500,

  mappings = {
    add = "sa",
    delete = "sd",
    find = "sf",
    find_left = "sF",
    highlight = "sh",
    replace = "sr",
    update_n_lines = "sn",

    suffix_last = "l",
    suffix_next = "n",
  },

  n_lines = 20,

  respect_selection_type = false,
  search_method = "cover",
})

-- === Tabout.nvim - Tab out of brackets, quotes, etc. ===
require("tabout").setup({
  tabkey = "<Tab>",
  backwards_tabkey = "<S-Tab>",
  act_as_tab = true,
  act_as_shift_tab = false,
  default_tab = "<C-t>",
  default_shift_tab = "<C-d>",
  enable_backwards = true,
  completion = true,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = "`", close = "`" },
    { open = "(", close = ")" },
    { open = "[", close = "]" },
    { open = "{", close = "}" },
  },
  ignore_beginning = true,
  exclude = {},
})

-- === Nvim-autopairs - Auto close brackets, quotes, etc. ===
-- (Already configured in plugins.lua, but here's an enhanced version)
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.setup({
  check_ts = true,      -- Use treesitter
  ts_config = {
    lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
    javascript = { "template_string" },
    java = false,       -- Don't check treesitter on java
  },
  disable_filetype = { "TelescopePrompt", "vim" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
})

-- Integration with nvim-cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Add spaces between parentheses
npairs.add_rules({
  Rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
  end),
  Rule("( ", " )")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match(".%)") ~= nil
      end)
      :use_key(")"),
  Rule("{ ", " }")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match(".%}") ~= nil
      end)
      :use_key("}"),
  Rule("[ ", " ]")
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match(".%]") ~= nil
      end)
      :use_key("]"),
})

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

return {}

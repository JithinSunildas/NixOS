-- ~/.config/nvim/lua/plugins/extra.lua

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

map({ "n", "x", "o" }, "s", function()
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

map({ "n" }, "<CR>", function()
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
    -- Configuration for different surroundings
    custom_surroundings = nil,

    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    highlight_duration = 500,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        add = "sa",            -- Add surrounding in Normal and Visual modes
        delete = "sd",         -- Delete surrounding
        find = "sf",           -- Find surrounding (to the right)
        find_left = "sF",      -- Find surrounding (to the left)
        highlight = "sh",      -- Highlight surrounding
        replace = "sr",        -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l",     -- Suffix to search with "prev" method
        suffix_next = "n",     -- Suffix to search with "next" method
    },

    -- Number of lines within which surrounding is searched
    n_lines = 20,

    -- Whether to respect selection type:
    -- - Place surroundings on separate lines in linewise mode.
    -- - Place surroundings on each line in blockwise mode.
    respect_selection_type = false,

    -- How to search for surrounding (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
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
    check_ts = true,        -- Use treesitter
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

-- === Nvim-treesitter-textobjects ===
-- Enhanced text objects based on treesitter
require("nvim-treesitter.configs").setup({
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V",  -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
                ["[A"] = "@parameter.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>sp"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>sP"] = "@parameter.inner",
            },
        },
    },
})

-- === Nvim-colorizer ===
-- (Already configured in plugins.lua, but here's an enhanced version)
require("colorizer").setup({
    filetypes = { "*" },
    user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
        always_update = false,
    },
    buftypes = {},
})

-- Colorizer commands
map("n", "<leader>ct", "<cmd>ColorizerToggle<cr>", { desc = "Toggle Colorizer" })
map("n", "<leader>ca", "<cmd>ColorizerAttachToBuffer<cr>", { desc = "Attach Colorizer" })
map("n", "<leader>cd", "<cmd>ColorizerDetachFromBuffer<cr>", { desc = "Detach Colorizer" })

-- === Vim-visual-multi (Multi-cursors) ===
-- Configure vim-visual-multi
vim.g.VM_leader = "\\"
-- vim.g.VM_theme = "iceblue"
vim.g.VM_highlight_matches = "underline"

-- Default mappings (these work out of the box):
-- <C-n>         Start multi-cursor, select next occurrence
-- <C-Down/Up>   Create cursors vertically
-- n/N           Get next/previous occurrence
-- [/]           Select next/previous cursor
-- q             Skip current and get next occurrence
-- Q             Remove current cursor/selection
-- <Tab>         Switch between cursor and extend mode
-- \\A           Select all occurrences
-- \\\/          Start regex search
-- \\\\          Add cursor at position
-- \\c           Toggle case sensitive search
-- \\f           Find with input
-- \\r           Start replace mode

-- Custom keymaps for easier access
vim.g.VM_maps = {
    ["Find Under"]         = "<C-n>",
    ["Find Subword Under"] = "<C-n>",
    ["Select Cursor Down"] = "<C-Down>",
    ["Select Cursor Up"]   = "<C-Up>",
    ["Select All"]         = "\\A",
    ["Start Regex Search"] = "\\/",
    ["Add Cursor At Pos"]  = "\\\\",
    ["Visual Regex"]       = "\\/",
    ["Visual All"]         = "\\A",
    ["Visual Add"]         = "\\a",
    ["Visual Find"]        = "\\f",
    ["Visual Cursors"]     = "\\c",
    ["Skip Region"]        = "q",
    ["Remove Region"]      = "Q",
    ["Invert Direction"]   = "o",
    ["Goto Prev"]          = "[",
    ["Goto Next"]          = "]",
    ["Seek Up"]            = "<C-b>",
    ["Seek Down"]          = "<C-f>",
    ["Toggle Mappings"]    = "\\<Space>",
}

return {}

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
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
map("n", "<leader>r", require('telescope.builtin').registers, { desc = "[F]ind [R]isters (Yank list)" })
map("v", "<leader>r", require('telescope.builtin').registers, { desc = "[F]ind [R]isters (Yank list)" })

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

return {}

-- ~/.config/nvim/config/lua/keymaps.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.mouse = ""

local map = vim.keymap.set

-- Disable space default behavior (since it's our leader key)
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- === General ===
-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save and --[[ quit ]]
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- Search and Replace
map('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre (Find and Replace)"
})
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word"
})

-- === Clipboard ===
-- System clipboard shortcuts
map("v", "<C-c>", '<Esc>gcc', { desc = "Comment/uncomment" })
map("n", "<C-c>", 'gcc', { desc = "Comment/uncomment" })
map("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select all" })
map("v", "<C-a>", "ggVG", { desc = "Select all" })

-- === Window Management ===
-- Navigate between windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Split windows
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertically" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increast width" })

-- === Tab Management ===
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
-- === Editing ===
-- Move lines up/down
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- Keep search matches centered
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "<C-n>", "viw", { desc = "Match word" })
map("n", "m", "vi", { desc = "Match inside" })
map("n", "N", "Nzzzv", { desc = "Previous match (centered)" })
map("n", "M", "va", { desc = "Match around" })
map("n", "R", "*Ncgn", { desc = "Change word under cursor" })

-- Better paste (don't yank replaced text)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- === Buffer Navigation ===
-- Note: Tab and S-Tab are configured in plugins.lua for bufferline
map("n", "<leader>q", "<cmd>b# | bd#<cr>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bb", "<cmd>b#<cr>", { desc = "Switch to last buffer" })
map("n", "<leader><Tab>", "<cmd>Telescope buffers<cr>", { desc = "List open buffers" })

-- === Terminal ===
-- Open terminal in split
map("n", "<leader>tt", "<cmd>tabnew | terminal<cr>", { desc = "Terminal (new tab)" })
map("n", "<leader>th", "<cmd>split | terminal<cr>", { desc = "Terminal horizontal" })
map("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal vertical" })

-- Exit terminal mode easily
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- === Quick Navigation ===
-- Jump to beginning/end of line
map({ "n", "v", "o" }, "<S-h>", "^", { desc = "Beginning of sentence" })
map({ "n", "v", "o" }, "<S-l>", "g_", { desc = "End of sentence" })
map({ "n", "v", "o" }, "gh", "0", { desc = "Beginning of line" })
map({ "n", "v", "o" }, "gl", "$", { desc = "End of line" })

-- === Powerful Insert mode ===
map("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
map("i", "<C-h>", "<C-Left>", { desc = "Move previous word" })
map("i", "<C-Del>", "<C-o>dw", { desc = "Delete next word" })
map("i", "<C-l>", "<C-Right>", { desc = "Move next word" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })

-- === Diagnostics ===
map("n", "<leader>xx", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "<leader>xl", "<cmd>lua vim.diagnostic.setloclist()<cr>", { desc = "Location list" })
map("n", "<leader>]", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" })
map("n", "<leader>[", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Next diagnostic" })
map('n', '<leader>d', function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show inline diagnostics" })

-- === Git (with gitsigns) ===
-- Navigation
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { expr = true, desc = "Next git hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { expr = true, desc = "Previous git hunk" })

-- Acggtions
map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })
map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo stage hunk" })
map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset buffer" })
map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
map("n", "<leader>hb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
map("n", "<leader>hd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff this" })

-- === Quick Actions ===
-- Source current file
map("n", "<leader><leader>", "<cmd>source %<cr>", { desc = "Source current file" })

-- Toggle options
map("n", "<leader>un", "<cmd>set nu!<cr>", { desc = "Toggle line numbers" })
map("n", "<leader>ur", "<cmd>set rnu!<cr>", { desc = "Toggle relative numbers" })
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle line wrap" })
map("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })

-- map("", "<up>", "<nop>", { noremap = true })
-- map("", "<down>", "<nop>", { noremap = true })
-- map("i", "<up>", "<nop>", { noremap = true })
-- map("i", "<down>", "<nop>", { noremap = true })

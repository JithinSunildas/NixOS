-- modules/home/neovim/config/keymaps.lua

-- Define a map function for brevity
local map = vim.keymap.set

-- Use leader key (default: Space)
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Leader key" })

-- General QOL (Quality of Life)
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit Buffer" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit All (Force)" })

-- Window Management
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- NvimTree Toggle (If you didn't add the keymap in plugins.lua)
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })

-- Other common Neovim keymaps here...
-- The keymaps for LSP are usually defined in the 'on_attach' function in lsp.lua!

-- Note: Since this file just sets keymaps, it typically does not need to return anything.

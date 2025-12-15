-- modules/home/neovim/config/keymaps.lua

-- Define a map function for brevity
local map = vim.keymap.set

-- Use leader key (default: Space)
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Leader key" })

-- =========================================================================
-- 1. WINDOW MANAGEMENT (C-h/j/k/l for movement)
-- =========================================================================
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Resize Up" })
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Resize Down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize Left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize Right" })


-- =========================================================================
-- 2. BUFFER / TAB MANAGEMENT (Bufferline and Built-in)
-- =========================================================================

-- Use Bufferline's functions for cycling (assuming it's installed)
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })

-- Close current buffer (without closing window)
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
-- Close all other buffers
map("n", "<leader>bo", "<cmd>bufdo %bd|e#<cr>", { desc = "Close Other Buffers" })


-- =========================================================================
-- 3. FILE SYSTEM & EXPLORER (NvimTree)
-- =========================================================================

-- Toggle NvimTree (File Explorer)
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
-- Focus on the current file in NvimTree
map("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Focus File in Explorer" })


-- =========================================================================
-- 4. FUZZY FINDING (Telescope)
-- =========================================================================

-- Root/Project Search (Uses git root if available, otherwise CWD)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles (Project)" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [G]rep (Project)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [B]uffers" })

-- Current Directory Search (Explicitly search only the CWD)
map("n", "<leader>sF", "<cmd>Telescope find_files cwd=.<cr>", { desc = "[S]earch [F]iles (CWD)" })
map("n", "<leader>sG", "<cmd>Telescope live_grep cwd=.<cr>", { desc = "[S]earch [G]rep (CWD)" })

-- Help, History, etc.
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Search Help" })
map("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "Search Recent Files" })


-- =========================================================================
-- 5. TEXT EDITING & UTILITIES
-- =========================================================================

-- Clear search highlights
map("n", "<leader>sc", "<cmd>nohlsearch<CR>", { desc = "[S]earch [C]lear highlights" })

-- Format current buffer (assuming LSP is available for formatting)
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format Buffer" })

-- Visual mode-specific: Re-indent code
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- =========================================================================
-- 6. GENERAL QOL (The essentials)
-- =========================================================================
-- map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit Buffer" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit All (Force)" })

-- Note: LSP-specific keymaps (gd, gr, K, etc.) are best kept in the on_attach
-- function of your LSP configuration to ensure they are only active in LSP-enabled buffers.

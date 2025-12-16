-- modules/home/neovim/config/lua/options.lua

local opt = vim.opt

-- [[ UI Configuration ]]
opt.termguicolors = true -- Enable 24-bit color
opt.number = true        -- Show line numbers
opt.relativenumber = true -- Show relative line numbers for navigation
opt.signcolumn = "yes"   -- Always show the sign column (for LSPs, git, etc.)
opt.scrolloff = 8        -- Keep 8 lines above/below the cursor when scrolling
opt.cmdheight = 1        -- Command line height
opt.cursorline = true
opt.cursorlineopt = "number,line"
vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })

-- [[ Tabs, Spaces, and Indentation ]]
opt.expandtab = true     -- Use spaces instead of tabs
opt.tabstop = 4          -- A tab character is 4 spaces wide
opt.shiftwidth = 4       -- Auto-indent commands (like << or >>) use 4 spaces
opt.smartindent = true   -- Insert indents automatically

-- [[ Search Configuration ]]
opt.ignorecase = true    -- Case-insensitive searching
opt.smartcase = true     -- But be case-sensitive if a search term contains a capital letter
opt.incsearch = true     -- Highlight matches as you type
opt.hlsearch = true      -- Highlight all search matches

-- [[ Clipboard and System Interaction ]]
-- 'unnamedplus' means the OS clipboard ('+ register') is the default register
opt.clipboard = "unnamedplus"

-- [[ Window Splitting ]]
-- Splits open below or to the right of the current window (more natural)
opt.splitbelow = true
opt.splitright = true

-- [[ Backups and Swaps ]]
opt.swapfile = false     -- Disable swap files (less error-prone with modern SSDs/systems)
opt.backup = false       -- Disable backups
opt.undofile = true      -- Enable persistent undo (undo history survives reboots)

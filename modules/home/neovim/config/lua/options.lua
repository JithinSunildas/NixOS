-- modules/home/neovim/config/lua/options.lua

local opt = vim.opt

-- [[ UI Configuration ]]
vim.opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.showmode = false
opt.laststatus = 3
opt.cmdheight = 1
vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })
opt.cursorlineopt = "number,line"
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↳ "
opt.colorcolumn = "80,120"

-- [[ Tabs, Spaces, and Indentation ]]
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- [[ Search Configuration ]]
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- [[ Clipboard and System Interaction ]]
opt.clipboard = "unnamedplus"

-- [[ Window Splitting ]]
opt.splitbelow = true
opt.splitright = true

-- Fold settings
vim.opt.foldmethod = "expr"                     -- Use expression for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99                          -- Start with all folds open

-- NETRW (EXPLORER) SETTINGS
vim.g.netrw_banner = 0       -- Hide the help banner (hit 'I' to toggle if needed)
vim.g.netrw_liststyle = 3    -- Use tree-style view
vim.g.netrw_browse_split = 4 -- Open files in the previous window
vim.g.netrw_altv = 1         -- Open vertical splits to the right
vim.g.netrw_winsize = 20     -- Default width of the Lexplore sidebar
vim.g.netrw_keepdir = 0      -- Sync current directory with browsing directory

-- [[ Backups and Swaps ]]
opt.swapfile = false -- Disable swap files (less error-prone with modern SSDs/systems)
opt.backup = false   -- Disable backups
opt.undofile = true  -- Enable persistent undo (undo history survives reboots)

vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "●",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        local line = mark[1]
        local ft = vim.bo.filetype
        if line > 0 and line <= lcount
            and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
            and not vim.o.diff then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- -- Auto-close terminal when process exits
-- vim.api.nvim_create_autocmd("TermClose", {
--   group = augroup,
--   callback = function()
--     if vim.v.event.status == 0 then
--       vim.api.nvim_buf_delete(0, {})
--     end
--   end,
-- })

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

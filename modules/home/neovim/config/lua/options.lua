-- modules/home/neovim/config/lua/options.lua

local opt = vim.opt

-- [[ UI Configuration ]]
vim.opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.cmdheight = 1
opt.cursorline = true
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

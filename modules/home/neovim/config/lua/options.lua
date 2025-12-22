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
opt.tabstop = 4
opt.shiftwidth = 4
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
vim.keymap.set('n', '<leader>k', function()
    vim.diagnostic.open_float({
        scope = "line",
        border = "rounded",
        focusable = false,
    })
end)

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     callback = function()
--         for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
--             if client.server_capabilities.documentFormattingProvider then
--                 vim.lsp.buf.format({ async = false })
--                 return
--             end
--         end
--     end,
-- })

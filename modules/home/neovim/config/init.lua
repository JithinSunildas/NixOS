-- ~/nix-config/modules/home/neovim/config/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_installed_by_nix = vim.fn.isdirectory(lazypath) == 0

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
  vim.g.neovide_scale_factor = 0.9
  vim.g.neovide_frame = "none"
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

if lazy_installed_by_nix then
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    if path:match("lazy%-nvim") then
      lazypath = path
      break
    end
  end
end

vim.opt.rtp:prepend(lazypath)

-- Load basic config FIRST (before lazy)
require("options")
require("keymaps")

require("lazy").setup("plugins.init", {
  defaults = {
    lazy = true,
  },
  install = {
    missing = true,
  },
  checker = {
    enabled = false,
  },
  performance = {
    rtp = {
      reset = false,
    },
  },
})

-- Load LSP and plugin configurations AFTER lazy setup
require("lsp")
require("plugins.setup")
require("plugins.extra")
-- vim.cmd("colorscheme kanso")
vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })

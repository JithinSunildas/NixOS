-- ~/.config/nvim/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim (it's already installed by Nix, so we just need to add it to runtimepath)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_installed_by_nix = vim.fn.isdirectory(lazypath) == 0

if lazy_installed_by_nix then
  -- When installed by Nix, lazy.nvim is already in the runtimepath
  -- We just need to find it
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    if path:match("lazy%-nvim") then
      lazypath = path
      break
    end
  end
end

vim.opt.rtp:prepend(lazypath)

-- Load options and keymaps first
require("options")
require("keymaps")

-- Setup lazy.nvim and load plugins
require("lazy").setup("plugins", {
  defaults = {
    lazy = true, -- Enable lazy-loading by default
  },
  install = {
    missing = true, -- Install missing plugins on startup
  },
  checker = {
    enabled = false, -- Don't check for updates automatically
  },
  performance = {
    rtp = {
      reset = false, -- Don't reset runtimepath (important for Nix)
    },
  },
})

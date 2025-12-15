-- modules/home/neovim/config/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local config_root = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("<sfile>")), ":h")
package.path = package.path .. ";" .. config_root .. "/?.lua"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load options and keymaps BEFORE plugins
require("options")
require("keymaps")

require("lazy").setup(require("plugins"), {})

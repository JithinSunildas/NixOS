-- modules/home/neovim/init.lua

local config_dir = vim.fn.stdpath("config")
package.path = package.path .. ";" .. config_dir .. "/?.lua"
package.path = package.path .. ";" .. config_dir .. "/?/init.lua"
package.path = package.path .. ";" .. config_dir .. "/plugins/?.lua"
-- ================================================
--
-- Basic settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core options
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Bootstrap lazy.nvim
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

-- Load plugin definitions from the plugins folder
require("plugins.alpha")
require("lazy").setup(require("plugins"))

-- Load all keymaps and final configurations
require("config")

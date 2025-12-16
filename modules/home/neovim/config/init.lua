-- ~/nix-config/modules/home/neovim/config/init.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_installed_by_nix = vim.fn.isdirectory(lazypath) == 0
local config_root = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("<sfile>")), ":h")
package.path = config_root .. "/lua/?.lua;" .. package.path

if lazy_installed_by_nix then
    for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
        if path:match("lazy%-nvim") then
            lazypath = path
            break
        end
    end
end

vim.opt.rtp:prepend(lazypath)

require("options")
require("lsp")
require("keymaps")

require("lazy").setup("plugins", {
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

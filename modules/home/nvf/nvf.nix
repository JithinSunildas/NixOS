# ~/nix-config/modules/home/nvf/nvf.nix

{ config, pkgs, lib, ... }:

{
  vim.enable = true;

  vim.options = {
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    relativenumber = true;
    cmdheight = 1;
    timeoutlen = 500;
  };

  # vim.theme = {
  #   enable = true;
  #   name = "tokyonight";
  #   style = "storm"; # A darker, less vibrant alternative to 'night'
  # };

  # 🧩 Languages, LSP, and Tools 
  vim.languages = {
    enableLSP = true;
    enableTreesitter = true;
    enableFormat = true;
    enableExtraDiagnostics = true;

    rust.enable = true;
    cpp.enable = true; 
    java.enable = true;
    haskell.enable = true;
    lua.enable = true; 
    nix.enable = true; 
  };

  vim.autocomplete.nvim-cmp.enable = true;
  vim.telescope.enable = true;
  vim.filetree.neo-tree.enable = true;
  vim.tabline.nvimBufferline.enable = true;
  vim.git.gitsigns.enable = true;

  vim.luaConfig = ''
    -- Set the leader key to <Space> (the superior leader, in my humble opinion)
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- Custom binding for Neo-tree (using <Leader> + 'e')
    vim.keymap.set('n', '<leader>e', function()
      require('neo-tree.command').execute({ toggle = true })
    end, { desc = "Toggle Neo-tree" })

    -- Example: Set up the Rust language server and formatting.
    -- (NVF often handles this, but here is where you'd place advanced overrides)
    local lspconfig = require('lspconfig')
    lspconfig.rust_analyzer.setup{}
    
    -- Haskell specific setup (may require nixpkgs overlays for tools like hlint/fourmolu)
    -- You would typically add the packages in 'home.packages' or via a Nix-side overlay.

  '';
}

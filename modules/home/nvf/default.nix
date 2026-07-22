{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      theme.enable = false;

      extraPlugins = with pkgs.vimPlugins; {
        kanagawa-nvim = {
          plugin = kanagawa-nvim;
        };
      };

      notes.todo-comments.enable = true;
      
      extraLuaConfig = ''
        require('kanagawa').setup({
          theme = "dragon", -- Load dragon theme by default
          background = {
            dark = "dragon",
            light = "lotus"
          },
        })
        vim.cmd("colorscheme kanagawa-dragon")
      '';

      viAlias = true;
      vimAlias = true;
      
      languages = {
        enableLSP = true;
        enableTreesitter = true;
        rust.enable = true;
        c.enable = true;
        nix.enable = true;
      };

      statusline.lualine.enable = true;

      utility.motion.flash = {
        enable = true;
      };

      extraLuaFiles = [
        ./lua/keymaps.lua
      ];
    };
  };
}

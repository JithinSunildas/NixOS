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

      luaConfigRC.kanagawa = ''
        require('kanagawa').setup({
          theme = "dragon",
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
        clang.enable = true;
        nix.enable = true;
      };

      statusline.lualine.enable = true;

      # Correct option path for flash
      utility.motion.flash-nvim = {
        enable = true;
      };

      extraLuaFiles = [
        ./lua/keymaps.lua
      ];
    };
  };
}

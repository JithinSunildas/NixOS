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
        clang.enable = true; # Changed from c.enable to clang.enable
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

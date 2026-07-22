{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      # Disable nvf's internal theme module so Kanagawa-Dragon applies cleanly
      theme.enable = false;

      # 1. Load kanagawa.nvim plugin
      extraPlugins = with pkgs.vimPlugins; {
        kanagawa-nvim = {
          plugin = kanagawa-nvim;
        };
      };

      # 2. Configure and apply kanagawa-dragon using luaConfigRC
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

      # Base Editor Settings
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

      # Import keymaps
      extraLuaFiles = [
        ./lua/keymaps.lua
      ];
    };
  };
}

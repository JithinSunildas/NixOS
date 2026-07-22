{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;

      languages = {
        enableLSP = true;
        enableTreesitter = true;
        
        rust.enable = true;
        clang.enable = true;
        nix.enable = true;
        lua.enable = true;
        zig.enable = true;
        typst.enable = true;
        markdown.enable = true;
      };

      statusline.lualine.enable = true;

      # Correct option path for flash
      utility.motion.flash-nvim = {
        enable = true;
      };

      extraLuaFiles = [
        ./lua/keymaps.lua
        ./lua/options.lua
        # ./lua/evilline.lua
      ];
    };
  };
}

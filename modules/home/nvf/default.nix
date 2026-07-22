{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      theme.enable = false;

      autocomplete.nvim-cmp.enable = true;
      snippets.luasnip.enable = true;

      utility.motion.flash-nvim.enable = true;
      utility.surround.enable = true;
      
      telescope.enable = true;
      git.gitsigns.enable = true;

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
        python.enable = true;
      };

      statusline.lualine.enable = true;

      extraPlugins = with pkgs.vimPlugins; {
        nvim-autopairs = {
          package = nvim-autopairs;
        };
        telescope-fzf-native-nvim = {
          package = telescope-fzf-native-nvim;
        };
      };

      extraLuaFiles = [
        ./lua/keymaps.lua
        ./lua/config.lua
        ./lua/options.lua
      ];
    };
  };
}

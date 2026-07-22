{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;

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
          plugin = nvim-autopairs;
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

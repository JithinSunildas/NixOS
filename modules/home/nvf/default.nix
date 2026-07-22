{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      lsp.enable = true;
      viAlias = true;

      autocomplete.nvim-cmp.enable = true;
      snippets.luasnip.enable = true;

      utility.motion.flash-nvim.enable = true;
      utility.surround.enable = true;
      
      telescope.enable = true;
      git.gitsigns.enable = true;

      languages = {
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

      luaConfigRC.dev-loader = ''
        local lua_dir = vim.fn.expand("~/nix-config/modules/home/nvf/lua/")
        
        dofile(lua_dir .. "init.lua")
      '';
    };
  };
}

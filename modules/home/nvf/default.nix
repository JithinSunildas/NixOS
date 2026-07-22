{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      lsp = {
        enable = true;
        formatOnSave = true;
      };
      viAlias = true;

      autocomplete.nvim-cmp.enable = true;
      snippets.luasnip.enable = true;

      utility = {
        motion.flash-nvim.enable = true;
        surround.enable = true;
        oil-nvim = {
          enable = true;
          setupOpts = {
            default_file_explorer = true;
            columns = [ "icon" ];
            view_options = {
              show_hidden = true;
            };
          };
        };
      };

      telescope.enable = true;
      git.gitsigns.enable = true;

      languages = {
        enableTreesitter = true;

        nix.enable = true;
        rust.enable = true;
        clang.enable = true;
        python.enable = true;
        lua.enable = true;
        java.enable = true;
        haskell.enable = true;
        go.enable = true;
        zig.enable = true;
        typst.enable = true;
        ocaml.enable = true;
        ts.enable = true;
        tailwind.enable = true;
        css.enable = true;
        html.enable = true;
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

        dofile(lua_dir .. "options.lua")
        dofile(lua_dir .. "keymaps.lua")
        dofile(lua_dir .. "config.lua")
        dofile(lua_dir .. "statusline.lua")
        dofile(lua_dir .. "floating_term.lua")
      '';
    };
  };
}

{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    # Add your favorite plugins here
    # Check out the nixos options to understand more
#    plugins = with pkgs.vimPlugins; [
#      plenary-nvim
#      telescope-nvim
#      lualine-nvim
#      nvim-tree-lua
#      # Add more plugins as you like
#    ];
    
    # Example for enabling LSP and other features
  };
}

# modules/home/nvf/nvf.nix
{ config, pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      useSystemClipboard = true;
      
      # Theme
      theme.enable = false;
      
      # Statusline
      statusline.lualine.enable = true;
      
      # Tabline
      tabline.nvimBufferline.enable = true;
      
      # File tree
      filetree.nvimTree.enable = true;
      
      # Telescope
      telescope.enable = true;
      
      # Treesitter
      treesitter.enable = true;
      
      # Git
      git.enable = true;
      
      # LSP - let languages section handle specific servers
      lsp = {
        enable = true;
        formatOnSave = true;
      };
      
      # Languages - this enables LSP for each language automatically
      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        
        rust.enable = true;
        ts.enable = true;
        html.enable = true;
        css.enable = true;
        python.enable = true;
        nix.enable = true;
        lua.enable = true;
        clang.enable = true;
      };
      
      # Visuals
      visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
      };
      
      # Autocomplete
      autocomplete.enable = true;
      
      # Terminal
      terminal.toggleterm.enable = true;
      
      # Keybindings
      binds.whichKey.enable = true;
      
      # Comments
      comments.comment-nvim.enable = true;
      
      # Autopairs
      autopairs.enable = true;
    };
  };
  
  # Additional packages
  home.packages = with pkgs; [
    flutter
    dart
    php83Packages.phpactor
    php83Packages.composer
    verible
    verilator
  ];
}

# modules/home/nvf/nvf.nix
{ config, pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      
      # Core settings
      lineNumberMode = "relNumber";
      preventJunkFiles = true;
      useSystemClipboard = true;
      
      # Theme - disable for Stylix
      theme.enable = false;
      
      # Statusline
      statusline.lualine = {
        enable = true;
        theme = "auto";
      };
      
      # Tabline
      tabline.nvimBufferline.enable = true;
      
      # File tree
      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
      };
      
      # Telescope
      telescope.enable = true;
      
      # Treesitter
      treesitter = {
        enable = true;
        fold = true;
      };
      
      # Git
      git = {
        enable = true;
        gitsigns.enable = true;
      };
      
      # LSP
      lsp = {
        enable = true;
        formatOnSave = true;
        
        # Language servers
        rust-analyzer.enable = true;
        ts-ls.enable = true;
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        pyright.enable = true;
        clangd.enable = true;
        nil.enable = true;
        lua-ls.enable = true;
      };
      
      # Languages
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
        indentBlankline.enable = true;
      };
      
      # UI
      ui = {
        borders.enable = true;
        noice.enable = true;
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
  
  # Additional packages for languages not built-in to NVF
  home.packages = with pkgs; [
    # Flutter/Dart
    flutter
    dart
    
    # PHP/Laravel
    phpactor
    php83Packages.composer
    php83Packages.phpstan
    php83Packages.php-cs-fixer    
    # Java
    jdt-language-server
    google-java-format
    maven
    gradle
    
    # Verilog
    verible
    verilator
  ];
}

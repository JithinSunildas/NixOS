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
      tabWidth = 4;
      autoIndent = true;
      syntaxHighlighting = true;
      mapLeaderSpace = true;
      
      # Theme - disable for Stylix
      theme.enable = false;
      
      # Statusline
      statusline.lualine = {
        enable = true;
        theme = "auto";
      };
      
      # Tabline
      tabline.nvimBufferline.enable = true;
      
      # Dashboard
      dashboard.dashboard-nvim.enable = true;
      
      # File tree
      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
        setupOpts = {
          view.width = 35;
          renderer.group_empty = true;
          filters.dotfiles = false;
        };
      };
      
      # Telescope
      telescope.enable = true;
      
      # Treesitter
      treesitter = {
        enable = true;
        fold = true;
        context.enable = true;
      };
      
      # Git
      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions = true;
      };
      
      # LSP
      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = true;
        lightbulb.enable = true;
        nvimCodeActionMenu.enable = true;
        
        # Language servers
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
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
        markdown.enable = true;
        bash.enable = true;
      };
      
      # Visuals
      visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        scrollBar.enable = true;
        smoothScroll.enable = true;
        indentBlankline = {
          enable = true;
          fillChar = "│";
        };
        cursorline.enable = true;
      };
      
      # Utility
      utility = {
        diffview-nvim.enable = true;
        motion = {
          hop.enable = true;
          leap.enable = true;
        };
      };
      
      # UI
      ui = {
        borders = {
          enable = true;
          globalStyle = "rounded";
        };
        noice.enable = true;
        colorizer.enable = true;
        illuminate.enable = true;
      };
      
      # Autocomplete
      autocomplete.enable = true;
      
      # Snippets
      snippets.luasnip.enable = true;
      
      # Terminal
      terminal.toggleterm = {
        enable = true;
        direction = "horizontal";
      };
      
      # Session
      session.nvim-session-manager.enable = true;
      
      # Keybindings
      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };
      
      # Comments
      comments.comment-nvim.enable = true;
      
      # Autopairs
      autopairs.enable = true;
      
      # Projects
      projects.project-nvim.enable = true;
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
    phpstan
    php-cs-fixer
    
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

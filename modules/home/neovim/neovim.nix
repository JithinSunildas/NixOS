# modules/home/neovim/nvim.nix
{ pkgs, ... }:

{
    home.packages = with pkgs; [
      clang-tools
      nil
      pyright
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted # html, css, json
      
      # Formatters
      black
      isort
      prettier
      stylua
      nixfmt-classic
      
      # Linters
      ruff
      
      # Tools for telescope
      ripgrep
      fd
      git
    ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # All your plugins managed by Nix
plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      
      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      
      # Treesitter
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.rust
        p.nix
        p.lua
        p.python
        p.java
        p.javascript
        p.typescript
        p.html
        p.css
        p.json
      ]))
      nvim-treesitter-textobjects
      
      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      
      # UI
      nvim-tree-lua
      lualine-nvim
      nvim-web-devicons
      bufferline-nvim
      which-key-nvim
      alpha-nvim
      
      # Git
      gitsigns-nvim
      
      # Utilities
      nvim-autopairs
      comment-nvim
      indent-blankline-nvim
      nvim-colorizer-lua
      flash-nvim
      vim-visual-multi
      fidget-nvim
      mini-nvim  
      tabout-nvim
    ];    

    # External tools needed by plugins
    extraPackages = with pkgs; [
      # Language servers
      clang-tools
      nil
      pyright
      vimPlugins.nvim-jdtls
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted # html, css, json
      
      # Formatters
      rustfmt
      black
      isort
      prettier
      stylua
      nixfmt-classic
      
      # Linters
      ruff
      
      # Tools for telescope
      ripgrep
      fd
      git
    ];
    
    extraLuaConfig = ''
      -- Load configuration
      require("options")
      require("keymaps")
      require("plugins")
    '';
  };
  
  # Copy config files to ~/.config/nvim
  xdg.configFile."nvim/lua" = {
    source = ./config/lua;
    recursive = true;
  };
}

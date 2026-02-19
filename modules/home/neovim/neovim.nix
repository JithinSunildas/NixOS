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
    haskell-language-server
    gopls
    zls
    (pkgs.lib.lowPrio pkgs.vimPlugins.flutter-tools-nvim)
    ocamlPackages.ocaml-lsp
    typescript-language-server
    tailwindcss-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    emmet-ls

    # Formatters
    black
    isort
    prettier
    stylua
    nixfmt
    google-java-format
    ormolu
    # Linters
    ruff
    # Tools for telescope
    ripgrep
    fd
    git
  ];

  programs.neovim = {
    package = pkgs.neovim;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # External tools needed by plugins
    extraPackages = with pkgs; [
      # Language servers
      clang-tools
      pyright
      vimPlugins.nvim-jdtls
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted # html, css, json
      # Formatters
      black
      isort
      prettier
      stylua
      nixfmt
      # Linters
      ruff
      # Tools for telescope
      ripgrep
      fd
      git
    ];
    initLua = ''
      -- This runs BEFORE init.lua
    '';
  };

  xdg.configFile."nvim/init.lua" = {
    # source = ./config/init.lua;
    source = ./config/suckless.lua;
  };

  xdg.configFile."nvim/lua" = {
    source = ./config/lua;
    recursive = true;
  };
}

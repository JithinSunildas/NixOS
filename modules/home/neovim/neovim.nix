# modules/home/neovim/nvim.nix
{ pkgs, config, ... }:
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
    initLua = ''
      -- This runs BEFORE init.lua
    '';
  };
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/tikhaboom/nix-config/modules/home/neovim/config";
  # xdg.configFile."nvim/init.lua" = {
  #   # source = ./config/init.lua;
  #   # source = ./config/suckless.lua;
  #   # source = ./config/symlink.lua;
  # };

  # xdg.configFile."nvim/lua" = {
  #   source = ./config/lua;
  #   recursive = true;
  # };
}

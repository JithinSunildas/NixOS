# modules/home/neovim/nvim.nix
{ config, pkgs, lib, ... }:

let
  initLua = ./init.lua;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # All LSPs, formatters, and tools via Nix
    extraPackages = with pkgs; [
      # Rust
      rust-analyzer
      rustfmt
      clippy
      
      # Flutter/Dart
      flutter
      dart
      
      # PHP/Laravel
      phpactor
      php83Packages.composer
      phpstan
      php-cs-fixer
      
      # JavaScript/TypeScript
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted  # html, css, json
      nodePackages.prettier
      nodePackages.eslint
      
      # Python
      pyright
      black
      isort
      ruff
      
      # Java/Spring
      jdt-language-server
      google-java-format
      maven
      gradle
      
      # C/C++
      clang-tools  # clangd
      cmake-language-server
      cmake-format
      
      # Verilog/SystemVerilog
      verible
      verilator
      
      # Lua
      lua-language-server
      stylua
      
      # Nix
      nixd
      nixfmt-rfc-style
      statix
      
      # Essential tools
      ripgrep
      fd
      tree-sitter
      gcc
      gnumake
      git
      curl
      unzip
      wget
    ];
    
    extraLuaConfig = builtins.readFile initLua;
  };
}

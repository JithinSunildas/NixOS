# modules/home/neovim/neovim.nix
{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Just the essentials to start
    extraPackages = with pkgs; [
      # Basic tools
      ripgrep    # For telescope grep
      fd         # For telescope file finding
      git        # For git integration
      
      # Rust LSP
      cargo      # Includes cargo-fmt
    ];
    
    # Load our Lua config
    extraLuaConfig = builtins.readFile ./init.lua;
  };
  
  # Make tools available in shell too
  home.packages = with pkgs; [
    ripgrep
    fd
    git
    cargo
  ];
}

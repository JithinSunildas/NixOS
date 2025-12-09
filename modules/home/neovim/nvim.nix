# modules/home/neovim/nvim.nix 
{ config, pkgs, lib, ... }:

let
  nvimConfigSrc = "${config.home.homeDirectory}/nix-config/modules/home/neovim"; 
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPackages = false;
    
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      ripgrep
      fd
      git
      cargo
    ];
  };
home.file = {
    # Target: ~/.config/nvim
    "${config.xdg.configHome}/nvim" = {
      # Source: The directory in your local Git repo
      source = nvimConfigSrc;
      # CRITICAL FIX: Use the native home.file linking mechanism
      type = "link";
    };
  };
  # Make tools available in shell too
  home.packages = with pkgs; [
    ripgrep
    fd
    git
    cargo
  ];
}

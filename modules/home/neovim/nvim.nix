# modules/home/neovim/nvim.nix (The NEW version)
{ config, pkgs, lib, ... }:

let
  # This path is relative to your flake root: ~/nix-config
  nvimConfigSrc = "/home/tikhaboom/nix-config/modules/home/neovim"; 
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
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
  
  home.file.".config/nvim".source = 
    lib.mkOutOfStoreSymlink nvimConfigSrc;

  # Make tools available in shell too
  home.packages = with pkgs; [
    ripgrep
    fd
    git
    cargo
  ];
}

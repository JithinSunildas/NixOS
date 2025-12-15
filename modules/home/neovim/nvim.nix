# modules/home/neovim/nvim.nix (The NEW version)
{ pkgs, ... }:

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
  
  home.file."/home/tikhaboom/.config/nvim" = {
    source = "/home/tikhaboom/nix-config/modules/home/neovim/config";
    recursive = true;
  };

  # Make tools available in shell too
  home.packages = with pkgs; [
    ripgrep
    fd
    git
    cargo
  ];
}

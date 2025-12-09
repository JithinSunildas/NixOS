# modules/home/neovim/nvim.nix 
{
home-manager.users.tikhaboom = { config, pkgs, lib, ... }: {
let
  nvimConfigSrc = "${config.home.homeDirectory}/nix-config/modules/home/neovim"; 
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
  home.file."${config.xdg.configHome}/nvim".source = 
    lib.mkOutOfStoreSymlink nvimConfigSrc;

  # Make tools available in shell too
  home.packages = with pkgs; [
    ripgrep
    fd
    git
    cargo
  ];
  };
}

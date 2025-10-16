{ config, pkgs, inputs, ... }:

{
  # Set up the basic Home Manager environment
  home.username = "tikhaboom";
  home.homeDirectory = "/home/tikhaboom";
  
  # This is crucial. It tells Home Manager that your flake inputs
  # are available here. This allows us to use `inputs.niri`.
  _module.args = {
    inherit inputs;
  };

  # Your user-specific packages go here.
  # These are the packages you just moved from configuration.nix.
  home.packages = with pkgs; [
    # Wayland-specific tools
    kitty
    alacritty
    mako
    fuzzel
    gnome-keyring
    kdePackages.polkit-kde-agent-1
    xdg-desktop-portal-gtk

    # CLI tools
    eza
    btop
    unzip
    htop
    fastfetch
    cmatrix
    cbonsai
    lsd

    # Development
  ];

  # Your dotfiles and other configurations, like Fish.
  programs.fish = {
    enable = true;
    # You can add fish-specific configurations here
  };
  
  # This value ensures that your configuration is reproducible
  # between different versions of Home Manager.
  home.stateVersion = "23.11";
}

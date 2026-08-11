# packages/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Base Packages ---
    home-manager
    ffmpeg
    limine
    throttled
    wget
    wl-clipboard-rs
    wl-clipboard
    git
    openssh
    curl
    wlogout
    libmtp
    fzf
    nh
    gnumake
    brightnessctl
    ly
    ripgrep
    xwayland
    xwayland-satellite
  ];
}

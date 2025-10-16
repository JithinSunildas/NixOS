{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include your hardware configuration here
    # ./hardware-configuration.nix
  ];

  # System settings
  networking.hostName = "SuperDuperComputer";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Set your timezone and locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable a display server and a display manager for Wayland
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Define your user account
  users.users.tikhaboom = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # System-wide packages. Any user can use these.
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    git
    neovim
    wget
    curl
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS version from which the configuration is
  # compatible.
  system.stateVersion = "23.11"; 
}

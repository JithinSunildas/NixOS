#Configuration.nix
{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # System Hardware and Structure
    ./hardware-configuration.nix
    ./packages/packages.nix
  ];

  # --- NixOS Core Settings ---
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  system.stateVersion = "25.05";
  
  # --- Bootloader ---
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;

  # --- Networking & Localization ---
  networking = {
    hostName = "SuperDuperComputer";
    networkmanager.enable = true;
    hosts = {
      "192.168.18.33" = [ "raspi.casa.local" ];
      "10.129.16.223" = [
        "blog.inlanefreight.local"
        "blog-dev.inlanefreight.local"
      ];
    };
  };

  # Timezone change applied
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- User & Home Manager Configuration ---
  users.users.tikhaboom = {
    isNormalUser = true;
    description = "tikhaboom";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
      "docker"
    ];
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
  };

  home-manager.users.tikhaboom = {
    imports = [
      ./modules/home/home.nix
    ];
    home.stateVersion = "25.05";
  };
  
  # --- System Environment & Services ---
  environment.systemPackages = with pkgs; [
    polkit
    nixfmt-rfc-style
    xwayland
    xwayland-satellite
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };
  
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  security.polkit.enable = true;
  virtualisation.docker.enable = true;

  # --- System Program Enables ---
  programs = {
    fish.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    wireshark.enable = true;

    niri.enable = true;

    xwayland.enable = true;

    obs-studio.enable = true;
    obs-studio.plugins = [ pkgs.obs-studio-plugins.wlrobs ];

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
  };
  
  xdg.portal.wlr.enable = true;
  
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
  
  services = {
    qbittorrent.enable = true;
    displayManager = {
      enable = true;
      ly.enable = true;
    };
    # services.openssh.enable = true;
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
}

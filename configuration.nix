#Configuration.nix
{
  pkgs,
    ...
}:

{
  imports = [
    ./hardware-configuration.nix
      ./packages/packages.nix
  ];

# --- NixOS Core Settings ---
  nixpkgs.config.allowUnfree = true;

# Hibernation swap space...
  swapDevices = [
  { device = "/dev/nvme0n1p3"; }
  ];
  boot.resumeDevice = "/dev/nvme0n1p3";
  boot.kernelParams = [ "mem_sleep_default=deep" ];
# services.logind.settings.Login.HandleLidSwitchExternalPower = "hibernate";
# services.logind.settings.Login.HandleLidSwitch = "hibernate";

  nix.settings.experimental-features = [
    "nix-command"
      "flakes"
  ];

  system.stateVersion = "25.05";

# --- Bootloader ---
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
    systemd-boot.graceful = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "uinput" ];

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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

# --- User Configuration ---
  users.users.tikhaboom = {
    isNormalUser = true;
    description = "tikhaboom";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
        "input"
        "libvirtd"
        "kvm"
        "uinput"
        "networkmanager"
        "wireshark"
        "docker"
        "adbusers"
        "video"
    ];
  };

# --- System Environment & Services ---
  environment.systemPackages = with pkgs; [
    polkit
      nixfmt-rfc-style
      xwayland
      xwayland-satellite
      android-tools
      dict
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
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

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
    emacs.enable = true;
  };

  services.gvfs.enable = true;
  programs.adb.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        config = ''
          (defsrc caps)
          (deflayer base @cap)
          (defalias cap (tap-hold 200 200 esc lctl))
          '';
      };
    };
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
  };

# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# networking.firewall.enable = false;
}

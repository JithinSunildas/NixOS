{ pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ./packages/packages.nix ];

  # --- NixOS Core Settings ---
  nixpkgs.config.allowUnfree = true;

  # Hibernation swap space...
  swapDevices = [{ device = "/dev/nvme0n1p3"; }];
  boot.resumeDevice = "/dev/nvme0n1p3";

  # Optimization: Silent boot + existing hibernation fixes
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
    "mem_sleep_default=s2idle"
    "nvme.noacpi=1"
  ];

  services.logind.settings.Login.HandleLidSwitchExternalPower = "suspend";
  services.logind.settings.Login.HandleLidSwitch = "suspend";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Optimization: Use all cores for your custom kernel build
  nix.settings.cores = 0;

  system.stateVersion = "25.05";

  # --- Bootloader (Limine) ---
  boot.loader = {
    systemd-boot.enable = false;
    limine = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      # Custom styling to match a clean setup
      extraConfig = ''
        TIMEOUT=3
        GRAPHICS=yes
        INTERFACE_RESOLUTION=1920x1080
        TERM_BACKDROP=000000
        TERM_BACKGROUND=1e1e2e
        TERM_FOREGROUND=cdd6f4
      '';
    };
    efi.canTouchEfiVariables = false;
  };

  # --- Custom Compiled Kernel ---
  boot.kernelPackages = pkgs.linuxPackages_latest.extend (self: super: {
    kernel = super.kernel.override {
      ignoreConfigErrors = true;
      structuredExtraConfig = with lib.kernel; {
        # Use lib.mkForce to override the default 'n' value
        PREEMPT = lib.mkForce yes;

        MCORE_NATIVE = yes;
      };
    };
  });
  boot.kernelModules = [ "uinput" ];

  # --- Networking & Localization ---
  networking = {
    hostName = "SuperDuperComputer";
    networkmanager.enable = true;
    hosts = {
      "192.168.18.33" = [ "raspi.casa.local" ];
      "10.129.16.223" =
        [ "blog.inlanefreight.local" "blog-dev.inlanefreight.local" ];
    };
  };

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

  # --- Environment ---
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

  # --- Services ---
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    qbittorrent.enable = true;
    displayManager = {
      enable = true;
      ly.enable = true;
    };
    openssh.enable = true;
    emacs.enable = true;
    gvfs.enable = true;
    kanata = {
      enable = true;
      keyboards.default.config = ''
        (defsrc caps esc)
        (deflayer base @cap caps)
        (defalias cap (tap-hold 200 200 esc lctl))
      '';
    };
    postgresql.enable = true;
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };

  security.polkit.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # --- Programs ---
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
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.wlrobs ];
    };
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
    packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  };

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
}

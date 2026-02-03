{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System utilities
    efibootmgr
    unzip
    cyme
    parted
    xxd
    xhost
    ninja
    pkg-config
    notify
    imagemagick
    ffmpegthumbnailer
    unar
    jq
    poppler-utils

    # File management
    yazi

    # System monitoring/management
    gparted
    gnome-disk-utility
    nautilus
  ];
programs.wlogout = {
  enable = true;
  # layout = [
  # ];
  style = ''
    * {
        background-image: none;
        font-family: "JetBrainsMono Nerd Font";
    }

    window {
        background-color: rgba(30, 30, 40, 0.7); /* Muted Sumi Ink with transparency */
        backdrop-filter: blur(10px);
    }

    button {
        color: #c8c093; /* Fuji White / Old Vellum */
        background-color: rgba(22, 22, 29, 0.5);
        border-style: solid;
        border-width: 1px;
        border-color: #54546d; /* Dragon Gray */
        border-radius: 8px;
        margin: 10px;
        transition: all 0.3s ease-in-out;
    }

    button:focus, button:active, button:hover {
        background-color: #c4746e; /* Dragon Red Accent */
        color: #16161d;
        border-color: #c4746e;
        outline-style: none;
    }
  '';
};
}

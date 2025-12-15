# modules/home/home.nix
{
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "tikhaboom";
  home.homeDirectory = "/home/tikhaboom";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    # inputs.nvf.homeManagerModules.default # Packages
    ./packages/system.nix
    ./packages/terminal.nix
    ./packages/wayland.nix
    ./packages/themes.nix
    ./packages/security.nix
    ./packages/development.nix
    ./packages/languages.nix
    ./packages/virtualization.nix
    ./packages/apps.nix

    # Configs
    ./niri/niri.nix
    ./waybar/waybar.nix
    ./theme/stylix.nix
    ./fish/fish.nix
    ./neovim/neovim.nix
    ./zellij/zellij.nix
    ./ghostty.nix
    ./spicetify.nix
    ./bash.nix
    ./tmux.nix
    ./dunst.nix
  ];

  ########################################
  # 🧬 Git config
  ########################################
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "JithinSunildas";
        user.email = "jithinsunildas6@gmail.com";
        init.defaultBranch = "main";
        pull.rebase = true;
        color.ui = "auto";
      };
    };
    bash.enable = true;
    fish.enable = true;
  };

  ########################################
  # 🖥️ Shell config (optional)
  ########################################
  services = {
    ssh-agent.enable = true;
    swww.enable = true;
    swaync.enable = true;
  };
}

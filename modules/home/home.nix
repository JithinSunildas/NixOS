# modules/home/home.nix
{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home = {
    username = "tikhaboom";
    homeDirectory = "/home/tikhaboom";
    stateVersion = "25.05";

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };
  };

  programs.home-manager.enable = true;

  imports = [
    ./default.nix
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
  };
}

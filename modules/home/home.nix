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

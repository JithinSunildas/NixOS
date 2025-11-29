{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    
    # Fish shell starts quietly by setting the fish_greeting variable to nothing
    interactiveShellInit = ''
      # Disable the default Fish shell greeting (makes startup "quiet")
      set -g fish_greeting "" 
      
      set -gx GOPATH $HOME/go
      starship init fish | source
    '';
    
    shellInit = ''
      fish_add_path $HOME/go/bin
      fish_add_path $HOME/.local/bin
    '';
    
    shellAliases = {
      ## Nix/System Management
      "ns" = "sudo nvim /etc/nixos/configuration.nix";
      "hn" = "nvim ~/nix-config/home.nix";
      "nr" = "sudo nixos-rebuild switch --flake .#SuperDuperComputer";
      "hr" = "home-manager switch --flake ~/nix-config#user@host";
      "nc" = "nix-collect-garbage -d";
      "nd" = "nix-store --query --requisites /run/current-system | grep -F /nix/store | xargs du -sh | sort -hr";
      "see" = "nix search nixpkgs";
      
      ## Essential Shell Aliases
      "q" = "exit";
      "ls" = "eza --icons";
      "ll" = "eza -l --icons";
      "la" = "eza -a --icons";
      ".." = "cd ..";
      "..." = "cd ../..";
      "grep" = "grep --color=auto";
      "psf" = "ps aux | grep -v grep | grep -i";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}

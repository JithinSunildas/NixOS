{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
      set -gx GOPATH $HOME/go
      starship init fish | source
    '';
    
    shellInit = ''
      fish_add_path $HOME/go/bin
      fish_add_path $HOME/.local/bin
    '';
    
    # Optional: Add aliases
    shellAliases = {
      # your aliases here
    };
  };
  
  programs.ghostty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "-l" ];
      };
    };
  };
}

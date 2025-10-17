{ config, pkgs, ... }:

{
  # ... existing configuration ...
  
  # Enable Zen Browser using its Home Manager module
  programs.zen-browser = {
    enable = true;
    # Since Zen is a Firefox-based browser, it often supports the 
    # same configuration options under the hood as programs.firefox.
    # Check the Zen flake documentation for specific options,
    # but general Firefox settings might work here.
    # e.g. for default profile settings:
    # profiles.<profilename> = { ... };
  };

  # ... rest of your configuration ...
}

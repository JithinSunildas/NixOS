# ~/nix-config/modules/home/tmux.nix

{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    mouse = true;
    terminal = "screen-256color";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    
    extraConfig = ''
      # Vim-like pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Vim-like pane resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      
      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      
      # Minimal status bar
      set -g status-position bottom
      set -g status-style 'bg=default fg=colour8'
      set -g status-left ""
      set -g status-right ""
      set -g status-justify left
      
      set -g window-status-current-style 'fg=colour7'
      set -g window-status-style 'fg=colour8'
      set -g window-status-format ' #I:#W '
      set -g window-status-current-format ' #I:#W '
      
      # Pane borders
      set -g pane-border-style 'fg=colour8'
      set -g pane-active-border-style 'fg=colour8'
      
      # Remove clutter
      set -g status-left-length 0
      set -g status-right-length 0
    '';
  };
}

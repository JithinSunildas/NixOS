# tmux.nix
{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # Change prefix to Ctrl-Space
    prefix = "C-Space";
    
    # Enable mouse support
    mouse = true;
    
    # Use 256 colors
    terminal = "screen-256color";
    
    # Start window numbering at 1
    baseIndex = 1;
    
    # Renumber windows when one is closed
    escapeTime = 0;
    historyLimit = 10000;
    
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux-fzf;
        extraConfig = ''
          bind-key "s" run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
        '';
      }
    ];
    
    extraConfig = ''
      set -as terminal-overrides ',*:kdch1=\E[3~'
      set -g xterm-keys on
      set-window-option -g xterm-keys on
      set -g default-terminal "xterm-256color"
      set -s escape-time 0

      # Vim-like pane navigation (no prefix needed!)
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R
      
      # Tab navigation (Alt + number)
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      
      # Alt-f: Toggle floating pane
      bind -n M-f display-popup -E -w 80% -h 80% -d "#{pane_current_path}"
      
      # Alt-n: Quick vertical split
      bind -n M-n split-window -h -c "#{pane_current_path}"
      bind -n M-z resize-pane -Z
      bind -n M-m last-pane \; resize-pane -Z
      
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
      
      # Popup border
      set -g popup-border-style 'fg=colour8'
      
      # Remove clutter
      set -g status-left-length 0
      set -g status-right-length 0
    '';
  };
}

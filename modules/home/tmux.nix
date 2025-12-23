{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "A-Space";
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    
    plugins = with pkgs.tmuxPlugins; [
      yank    
    ];
    sensible
    extraConfig = ''
      bind -n 'M-f' display-popup -E -w 80% -h 80% "fish"
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Smart pane switching with awareness of Vim splits.
      # This works with 'christoomey/vim-tmux-navigator' in Neovim
      bind-key -n 'A-h' select-pane -L
      bind-key -n 'A-j' select-pane -D
      bind-key -n 'A-k' select-pane -U
      bind-key -n 'A-l' select-pane -R

      # --- Theme & Visuals ---
      set -g status-position top 
      set -g @theme_variant "vanzi"
      set -g @bg_transparency "on"
      
      # If use external plugins manually:
      run-shell "~/.config/tmux/plugins/vanzi-tmux-theme/vanzi.tmux"
      # run '~/.config/tmux/plugins/tpm/tpm' # Usually not needed if using nix plugins
    '';
  };
}

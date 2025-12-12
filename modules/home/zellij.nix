{ config, ... }:

let
  zellijConfig = ''
    ui {
      status false
    }

    theme "kanagawa"
    simplified_ui true
    ui_mode "compact"
    show_startup_tips false
    default_shell "fish"
    pane_frames true
    auto_layout true
    session_serialization false
    copy_on_select true
    scrollback_editor "nvim"
    mirror_session false
    layout_dir "${config.home.homeDirectory}/.config/zellij/layouts"
    theme_dir "${config.home.homeDirectory}/.config/zellij/themes"
    mouse_mode true
    scroll_buffer_size 10000
    copy_command "wl-copy"
    copy_clipboard "primary"

    ui {
      pane_frames {
        rounded_corners true
        hide_session_name false
      }
    }

    keybinds {
      # paste your giant keybind KDL here exactly as Zellij expects
      # NOT as Nix attribute sets
    }
  '';
in
{
  programs.zellij.enable = true;

  xdg.configFile."zellij/config.kdl".text = zellijConfig;

  home.shellAliases = {
    zj = "zellij";
    zja = "zellij attach";
    zjl = "zellij list-sessions";
    zjk = "zellij kill-session";
  };
}

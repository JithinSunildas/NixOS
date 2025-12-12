{ config, ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;

    settings = {
      theme = "kanagawa";
      simplified_ui = true;
      ui_mode = "compact";
      default_shell = "fish";
      pane_frames = true;
      auto_layout = true;
      session_serialization = false;
      copy_on_select = true;
      scrollback_editor = "nvim";
      mirror_session = false;
      layout_dir = "${config.home.homeDirectory}/.config/zellij/layouts";
      theme_dir = "${config.home.homeDirectory}/.config/zellij/themes";
      mouse_mode = true;
      scroll_buffer_size = 10000;
      copy_command = "wl-copy";
      copy_clipboard = "primary";
      ui = {
        pane_frames = {
          rounded_corners = true;
          hide_session_name = false;
        };
      };

      # Keybindings
      keybinds = {
        normal = {
          "bind \"Ctrl q\"" = {
            Quit = { };
          };

          # Pane management (Ctrl+p prefix)
          "bind \"Ctrl p\"" = {
            SwitchToMode = "pane";
          };

          # Tab management (Ctrl+t prefix)
          "bind \"Ctrl t\"" = {
            SwitchToMode = "tab";
          };

          # Resize mode (Ctrl+r prefix)
          "bind \"Ctrl r\"" = {
            SwitchToMode = "resize";
          };

          # Move mode (Ctrl+m prefix)
          "bind \"Ctrl m\"" = {
            SwitchToMode = "move";
          };

          # Search mode (Ctrl+s)
          "bind \"Ctrl s\"" = {
            SwitchToMode = "search";
          };

          # Session mode (Ctrl+o)
          "bind \"Ctrl o\"" = {
            SwitchToMode = "session";
          };

          # Scroll mode (Ctrl+[)
          "bind \"Ctrl [\"" = {
            SwitchToMode = "scroll";
          };

          # Quick pane actions without mode
          "bind \"Alt h\"" = {
            MoveFocus = "Left";
          };
          "bind \"Alt l\"" = {
            MoveFocus = "Right";
          };
          "bind \"Alt j\"" = {
            MoveFocus = "Down";
          };
          "bind \"Alt k\"" = {
            MoveFocus = "Up";
          };

          # Quick splits
          "bind \"Alt -\"" = {
            NewPane = {
              direction = "Down";
            };
          };
          "bind \"Alt |\"" = {
            NewPane = {
              direction = "Right";
            };
          };

          # Close pane
          "bind \"Alt w\"" = {
            CloseFocus = { };
          };

          # New tab
          "bind \"Alt t\"" = {
            NewTab = { };
          };

          # Next/Previous tab
          "bind \"Alt n\"" = {
            GoToNextTab = { };
          };
          "bind \"Alt p\"" = {
            GoToPreviousTab = { };
          };

          # Fullscreen toggle
          "bind \"Alt f\"" = {
            ToggleFocusFullscreen = { };
          };

          # Floating pane toggle
          "bind \"Alt z\"" = {
            ToggleFloatingPanes = { };
          };

          # Detach
          "bind \"Alt d\"" = {
            Detach = { };
          };
        };

        # Pane mode
        pane = {
          "bind \"Esc\"" = {
            SwitchToMode = "normal";
          };
          "bind \"Enter\"" = {
            SwitchToMode = "normal";
          };

          # Navigation
          "bind \"h\"" = {
            MoveFocus = "Left";
          };
          "bind \"l\"" = {
            MoveFocus = "Right";
          };
          "bind \"j\"" = {
            MoveFocus = "Down";
          };
          "bind \"k\"" = {
            MoveFocus = "Up";
          };

          # Splits
          "bind \"-\"" = {
            NewPane = {
              direction = "Down";
            };
            SwitchToMode = "normal";
          };
          "bind \"|\"" = {
            NewPane = {
              direction = "Right";
            };
            SwitchToMode = "normal";
          };

          # Close
          "bind \"w\"" = {
            CloseFocus = { };
            SwitchToMode = "normal";
          };

          # Fullscreen
          "bind \"f\"" = {
            ToggleFocusFullscreen = { };
            SwitchToMode = "normal";
          };

          # Rename
          "bind \"r\"" = {
            SwitchToMode = "RenamePane";
            PaneNameInput = 0;
          };
        };

        # Tab mode
        tab = {
          "bind \"Esc\"" = {
            SwitchToMode = "normal";
          };
          "bind \"Enter\"" = {
            SwitchToMode = "normal";
          };

          # Navigation
          "bind \"h\"" = {
            GoToPreviousTab = { };
          };
          "bind \"l\"" = {
            GoToNextTab = { };
          };
          "bind \"n\"" = {
            NewTab = { };
            SwitchToMode = "normal";
          };

          # Close tab
          "bind \"w\"" = {
            CloseTab = { };
            SwitchToMode = "normal";
          };

          # Rename tab
          "bind \"r\"" = {
            SwitchToMode = "RenameTab";
            TabNameInput = 0;
          };

          # Switch to tab by number
          "bind \"1\"" = {
            GoToTab = 1;
            SwitchToMode = "normal";
          };
          "bind \"2\"" = {
            GoToTab = 2;
            SwitchToMode = "normal";
          };
          "bind \"3\"" = {
            GoToTab = 3;
            SwitchToMode = "normal";
          };
          "bind \"4\"" = {
            GoToTab = 4;
            SwitchToMode = "normal";
          };
          "bind \"5\"" = {
            GoToTab = 5;
            SwitchToMode = "normal";
          };
          "bind \"6\"" = {
            GoToTab = 6;
            SwitchToMode = "normal";
          };
          "bind \"7\"" = {
            GoToTab = 7;
            SwitchToMode = "normal";
          };
          "bind \"8\"" = {
            GoToTab = 8;
            SwitchToMode = "normal";
          };
          "bind \"9\"" = {
            GoToTab = 9;
            SwitchToMode = "normal";
          };
        };

        # Resize mode
        resize = {
          "bind \"Esc\"" = {
            SwitchToMode = "normal";
          };
          "bind \"Enter\"" = {
            SwitchToMode = "normal";
          };

          "bind \"h\"" = {
            Resize = "Increase Left";
          };
          "bind \"l\"" = {
            Resize = "Increase Right";
          };
          "bind \"j\"" = {
            Resize = "Increase Down";
          };
          "bind \"k\"" = {
            Resize = "Increase Up";
          };

          "bind \"H\"" = {
            Resize = "Decrease Left";
          };
          "bind \"L\"" = {
            Resize = "Decrease Right";
          };
          "bind \"J\"" = {
            Resize = "Decrease Down";
          };
          "bind \"K\"" = {
            Resize = "Decrease Up";
          };

          "bind \"=\"" = {
            Resize = "Increase";
          };
          "bind \"-\"" = {
            Resize = "Decrease";
          };
        };

        # Move mode
        move = {
          "bind \"Esc\"" = {
            SwitchToMode = "normal";
          };
          "bind \"Enter\"" = {
            SwitchToMode = "normal";
          };

          "bind \"h\"" = {
            MovePane = "Left";
          };
          "bind \"l\"" = {
            MovePane = "Right";
          };
          "bind \"j\"" = {
            MovePane = "Down";
          };
          "bind \"k\"" = {
            MovePane = "Up";
          };

          "bind \"n\"" = {
            NewPane = { };
            SwitchToMode = "normal";
          };
        };

        # Search mode
        search = {
          "bind \"Esc\"" = {
            SwitchToMode = "normal";
          };
          "bind \"Enter\"" = {
            SwitchToMode = "normal";
          };

          "bind \"n\"" = {
            Search = "down";
          };
          "bind \"p\"" = {
            Search = "up";
          };
          "bind \"c\"" = {
            SearchToggleOption = "CaseSensitivity";
          };
          "bind \"w\"" = {
            SearchToggleOption = "Wrap";
          };
          "bind \"o\"" = {
            SearchToggleOption = "WholeWord";
          };
        };

        # Scroll mode
        scroll = {
          "bind \"Esc\"" = {
            SwitchToMode = "normal";
          };
          "bind \"Enter\"" = {
            SwitchToMode = "normal";
          };

          "bind \"j\"" = {
            ScrollDown = { };
          };
          "bind \"k\"" = {
            ScrollUp = { };
          };
          "bind \"d\"" = {
            HalfPageScrollDown = { };
          };
          "bind \"u\"" = {
            HalfPageScrollUp = { };
          };
          "bind \"f\"" = {
            PageScrollDown = { };
          };
          "bind \"b\"" = {
            PageScrollUp = { };
          };

          "bind \"s\"" = {
            SwitchToMode = "entersearch";
          };
          "bind \"e\"" = {
            EditScrollback = { };
          };
        };

        # Session mode
        session = {
          "bind \"Esc\"" = {
            SwitchToMode = "normal";
          };
          "bind \"Enter\"" = {
            SwitchToMode = "normal";
          };

          "bind \"d\"" = {
            Detach = { };
            SwitchToMode = "normal";
          };
        };
      };
    };
  };

  # Useful aliases
  home.shellAliases = {
    zj = "zellij";
    zja = "zellij attach";
    zjl = "zellij list-sessions";
    zjk = "zellij kill-session";
  };
}

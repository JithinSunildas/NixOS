{ pkgs, config, ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    
    settings = {
      # Theme - using Stylix colors
      theme = "kanagawa";
      
      # Simplified UI
      simplified_ui = true;
      
      # Default shell
      default_shell = "fish";
      
      # Pane frames
      pane_frames = true;
      
      # Auto layout
      auto_layout = true;
      
      # Session serialization
      session_serialization = false;
      
      # Copy on select
      copy_on_select = true;
      
      # Scrollback editor
      scrollback_editor = "nvim";
      
      # Mirror session
      mirror_session = false;
      
      # Layout directory
      layout_dir = "${config.home.homeDirectory}/.config/zellij/layouts";
      
      # Theme directory  
      theme_dir = "${config.home.homeDirectory}/.config/zellij/themes";
      
      # Mouse mode
      mouse_mode = true;
      
      # Scroll buffer size
      scroll_buffer_size = 10000;
      
      # Copy command
      copy_command = "wl-copy";
      
      # Clipboard provider
      copy_clipboard = "primary";
      
      # UI configuration
      ui = {
        pane_frames = {
          rounded_corners = true;
          hide_session_name = false;
        };
      };
      
      # Keybindings
      keybinds = {
        # Normal mode (default)
        normal = {
          # Unbind default Ctrl+q to avoid conflicts
          "bind \"Ctrl q\"" = { Quit = {}; };
          
          # Pane management (Ctrl+p prefix)
          "bind \"Ctrl p\"" = { SwitchToMode = "pane"; };
          
          # Tab management (Ctrl+t prefix) 
          "bind \"Ctrl t\"" = { SwitchToMode = "tab"; };
          
          # Resize mode (Ctrl+r prefix)
          "bind \"Ctrl r\"" = { SwitchToMode = "resize"; };
          
          # Move mode (Ctrl+m prefix)
          "bind \"Ctrl m\"" = { SwitchToMode = "move"; };
          
          # Search mode (Ctrl+s)
          "bind \"Ctrl s\"" = { SwitchToMode = "search"; };
          
          # Session mode (Ctrl+o)
          "bind \"Ctrl o\"" = { SwitchToMode = "session"; };
          
          # Scroll mode (Ctrl+[)
          "bind \"Ctrl [\"" = { SwitchToMode = "scroll"; };
          
          # Quick pane actions without mode
          "bind \"Alt h\"" = { MoveFocus = "Left"; };
          "bind \"Alt l\"" = { MoveFocus = "Right"; };
          "bind \"Alt j\"" = { MoveFocus = "Down"; };
          "bind \"Alt k\"" = { MoveFocus = "Up"; };
          
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
          "bind \"Alt w\"" = { CloseFocus = {}; };
          
          # New tab
          "bind \"Alt t\"" = { NewTab = {}; };
          
          # Next/Previous tab
          "bind \"Alt n\"" = { GoToNextTab = {}; };
          "bind \"Alt p\"" = { GoToPreviousTab = {}; };
          
          # Fullscreen toggle
          "bind \"Alt f\"" = { ToggleFocusFullscreen = {}; };
          
          # Floating pane toggle
          "bind \"Alt z\"" = { ToggleFloatingPanes = {}; };
          
          # Detach
          "bind \"Alt d\"" = { Detach = {}; };
        };
        
        # Pane mode
        pane = {
          "bind \"Esc\"" = { SwitchToMode = "normal"; };
          "bind \"Enter\"" = { SwitchToMode = "normal"; };
          
          # Navigation
          "bind \"h\"" = { MoveFocus = "Left"; };
          "bind \"l\"" = { MoveFocus = "Right"; };
          "bind \"j\"" = { MoveFocus = "Down"; };
          "bind \"k\"" = { MoveFocus = "Up"; };
          
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
            CloseFocus = {};
            SwitchToMode = "normal";
          };
          
          # Fullscreen
          "bind \"f\"" = { 
            ToggleFocusFullscreen = {};
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
          "bind \"Esc\"" = { SwitchToMode = "normal"; };
          "bind \"Enter\"" = { SwitchToMode = "normal"; };
          
          # Navigation
          "bind \"h\"" = { GoToPreviousTab = {}; };
          "bind \"l\"" = { GoToNextTab = {}; };
          "bind \"n\"" = { 
            NewTab = {};
            SwitchToMode = "normal";
          };
          
          # Close tab
          "bind \"w\"" = { 
            CloseTab = {};
            SwitchToMode = "normal";
          };
          
          # Rename tab
          "bind \"r\"" = { 
            SwitchToMode = "RenameTab";
            TabNameInput = 0;
          };
          
          # Switch to tab by number
          "bind \"1\"" = { GoToTab = 1; SwitchToMode = "normal"; };
          "bind \"2\"" = { GoToTab = 2; SwitchToMode = "normal"; };
          "bind \"3\"" = { GoToTab = 3; SwitchToMode = "normal"; };
          "bind \"4\"" = { GoToTab = 4; SwitchToMode = "normal"; };
          "bind \"5\"" = { GoToTab = 5; SwitchToMode = "normal"; };
          "bind \"6\"" = { GoToTab = 6; SwitchToMode = "normal"; };
          "bind \"7\"" = { GoToTab = 7; SwitchToMode = "normal"; };
          "bind \"8\"" = { GoToTab = 8; SwitchToMode = "normal"; };
          "bind \"9\"" = { GoToTab = 9; SwitchToMode = "normal"; };
        };
        
        # Resize mode
        resize = {
          "bind \"Esc\"" = { SwitchToMode = "normal"; };
          "bind \"Enter\"" = { SwitchToMode = "normal"; };
          
          "bind \"h\"" = { Resize = "Increase Left"; };
          "bind \"l\"" = { Resize = "Increase Right"; };
          "bind \"j\"" = { Resize = "Increase Down"; };
          "bind \"k\"" = { Resize = "Increase Up"; };
          
          "bind \"H\"" = { Resize = "Decrease Left"; };
          "bind \"L\"" = { Resize = "Decrease Right"; };
          "bind \"J\"" = { Resize = "Decrease Down"; };
          "bind \"K\"" = { Resize = "Decrease Up"; };
          
          "bind \"=\"" = { Resize = "Increase"; };
          "bind \"-\"" = { Resize = "Decrease"; };
        };
        
        # Move mode
        move = {
          "bind \"Esc\"" = { SwitchToMode = "normal"; };
          "bind \"Enter\"" = { SwitchToMode = "normal"; };
          
          "bind \"h\"" = { MovePane = "Left"; };
          "bind \"l\"" = { MovePane = "Right"; };
          "bind \"j\"" = { MovePane = "Down"; };
          "bind \"k\"" = { MovePane = "Up"; };
          
          "bind \"n\"" = { 
            NewPane = {};
            SwitchToMode = "normal";
          };
        };
        
        # Search mode
        search = {
          "bind \"Esc\"" = { SwitchToMode = "normal"; };
          "bind \"Enter\"" = { SwitchToMode = "normal"; };
          
          "bind \"n\"" = { Search = "down"; };
          "bind \"p\"" = { Search = "up"; };
          "bind \"c\"" = { SearchToggleOption = "CaseSensitivity"; };
          "bind \"w\"" = { SearchToggleOption = "Wrap"; };
          "bind \"o\"" = { SearchToggleOption = "WholeWord"; };
        };
        
        # Scroll mode
        scroll = {
          "bind \"Esc\"" = { SwitchToMode = "normal"; };
          "bind \"Enter\"" = { SwitchToMode = "normal"; };
          
          "bind \"j\"" = { ScrollDown = {}; };
          "bind \"k\"" = { ScrollUp = {}; };
          "bind \"d\"" = { HalfPageScrollDown = {}; };
          "bind \"u\"" = { HalfPageScrollUp = {}; };
          "bind \"f\"" = { PageScrollDown = {}; };
          "bind \"b\"" = { PageScrollUp = {}; };
          
          "bind \"s\"" = { SwitchToMode = "entersearch"; };
          "bind \"e\"" = { EditScrollback = {}; };
        };
        
        # Session mode
        session = {
          "bind \"Esc\"" = { SwitchToMode = "normal"; };
          "bind \"Enter\"" = { SwitchToMode = "normal"; };
          
          "bind \"d\"" = { 
            Detach = {};
            SwitchToMode = "normal";
          };
          "bind \"w\"" = {
            LaunchOrFocusPlugin = {
              floating = true;
              move_to_focused_tab = true;
            };
          };
        };
      };
    };
  };
  
  # Custom Kanagawa theme for Zellij
  home.file.".config/zellij/themes/kanagawa.kdl".text = ''
    themes {
      kanagawa {
        fg "${config.lib.stylix.colors.base05}"
        bg "${config.lib.stylix.colors.base00}"
        black "${config.lib.stylix.colors.base00}"
        red "${config.lib.stylix.colors.base08}"
        green "${config.lib.stylix.colors.base0B}"
        yellow "${config.lib.stylix.colors.base0A}"
        blue "${config.lib.stylix.colors.base0D}"
        magenta "${config.lib.stylix.colors.base0E}"
        cyan "${config.lib.stylix.colors.base0C}"
        white "${config.lib.stylix.colors.base05}"
        orange "${config.lib.stylix.colors.base09}"
      }
    }
  '';
  
  # Useful aliases
  home.shellAliases = {
    zj = "zellij";
    zja = "zellij attach";
    zjl = "zellij list-sessions";
    zjk = "zellij kill-session";
  };
}

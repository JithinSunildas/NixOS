# modules/home/swaync/swaync.nix

{ pkgs, ... }:
{
  services.swaync = {
    enable = true;
    
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "overlay";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      relative-timestamps = true;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 400;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "mpris"
        "notifications"
      ];
      
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Notification Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
          blur = true;
        };
        volume = {
          label = "󰕾";
        };
        backlight = {
          label = "󰃟";
        };
        menubar = {
          "menu#power-buttons" = {
            label = "⏻";
            position = "right";
            actions = [
              {
                label = "󰐥 Shutdown";
                command = "systemctl poweroff";
              }
              {
                label = "󰜉 Reboot";
                command = "systemctl reboot";
              }
              {
                label = "󰤄 Suspend";
                command = "systemctl suspend";
              }
              {
                label = "󰍃 Logout";
                command = "niri msg action quit";
              }
            ];
          };
        };
      };
      
      scripts = {
        example-script = {
          exec = "echo 'Do something...'";
          urgency = "Normal";
        };
      };
    };
    
    # Custom styling
style = ''
  /* SwayNC - Structural Fix & Glass UI */
  * {
    all: unset;
    font-family: "JetBrainsMono Nerd Font", "Inter", sans-serif;
  }

  /* --- MAIN WINDOW --- */
  .control-center {
    background: rgba(20, 20, 25, 0.95);
    border-radius: 24px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    margin: 10px;
    padding: 16px;
    backdrop-filter: blur(12px);
  }

  /* --- MPRIS WIDGET --- */
  .widget-mpris {
    background: rgba(255, 255, 255, 0.05);
    border-radius: 18px;
    padding: 12px;
    margin: 10px;
  }

  /* layout: album art + text + controls */
  .widget-mpris-player {
    display: flex;
    align-items: center;
    gap: 15px;
    width: 100%;
  }

  .widget-mpris-album-art {
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
    min-width: 64px; /* prevents shrinking on small layouts */
    min-height: 64px;
  }

  .widget-mpris-content {
    flex-grow: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  .widget-mpris-title {
    font-size: 16px;
    font-weight: bold;
    color: #61afef;
    padding-bottom: 2px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .widget-mpris-subtitle {
    font-size: 13px;
    color: rgba(255, 255, 255, 0.7);
    padding-bottom: 10px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  /* controls container might vary, so target buttons directly */
  .widget-mpris button {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
    padding: 5px 15px;
    margin: 5px;
    color: white;
  }

  .widget-mpris button:hover {
    background: rgba(255, 255, 255, 0.2);
    color: #c678dd;
  }

  /* --- NOTIFICATIONS --- */
  .notification {
    background: rgba(40, 44, 52, 0.5);
    border-radius: 15px;
    border: 1px solid rgba(255, 255, 255, 0.05);
    margin: 8px;
    padding: 12px;

    display: flex;
    gap: 10px;
    align-items: flex-start;
  }

  .notification-content {
    margin: 5px;
    flex-grow: 1;
    min-width: 0;
  }

  .summary {
    font-weight: bold;
    color: #e06c75;
    font-size: 15px;
    word-wrap: break-word;
  }

  .body {
    color: #abb2bf;
    font-size: 13px;
    word-wrap: break-word;
  }

  /* --- TITLES & BUTTONS --- */
  .widget-title {
    color: white;
    font-size: 20px;
    font-weight: bold;
    padding: 10px;
  }

  .widget-title > button {
    background: rgba(224, 108, 117, 0.2);
    color: #e06c75;
    border-radius: 10px;
    padding: 5px 15px;
  }

  /* --- DND WIDGET --- */
  .widget-dnd {
    background: rgba(255, 255, 255, 0.03);
    border-radius: 15px;
    padding: 10px;
    margin: 10px;
  }

  /* --- SCROLLBAR --- */
  scrollbar trough {
    background: transparent;
  }
  scrollbar slider {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
  }
'';
  };
}

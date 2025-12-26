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
      /* SwayNC - Modern Glassmorphism & Fixed Layout */

      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font", "Inter", sans-serif;
        font-size: 14px;
      }

      /* Control Center Container */
      .control-center {
        background: rgba(20, 20, 25, 0.92);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 18px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
      }

      /* Fixed MPRIS Widget - No more overlapping */
      .widget-mpris {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 16px;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid rgba(255, 255, 255, 0.05);
      }

      /* Ensure content flows horizontally: Art | Text */
      .widget-mpris-player {
        padding: 6px;
        background: transparent;
      }

      .widget-mpris-album-art {
        border-radius: 12px;
        margin-right: 15px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
      }

      /* Text Container - Prevents overlapping thumbnail */
      .widget-mpris-title {
        font-size: 16px;
        font-weight: 800;
        color: #ffffff;
        margin-bottom: 2px;
      }

      .widget-mpris-subtitle {
        font-size: 13px;
        color: rgba(255, 255, 255, 0.6);
        margin-bottom: 12px;
      }

      /* Controls Layout - Balanced Visibility */
      .widget-mpris > box > button {
        background: rgba(255, 255, 255, 0.08);
        color: #ffffff;
        border-radius: 50%; /* Circular buttons */
        padding: 10px;
        margin: 0 6px;
        min-width: 32px;
        min-height: 32px;
        transition: all 0.2s ease-in-out;
      }

      .widget-mpris > box > button:hover {
        background: #61afef;
        color: #1a1b26;
        transform: scale(1.1);
      }

      /* Progress Bar Styling */
      .widget-mpris scale {
        padding: 0;
        margin-top: 10px;
      }

      .widget-mpris scale trough {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 10px;
        min-height: 6px;
      }

      .widget-mpris scale trough highlight {
        background: linear-gradient(90deg, #61afef, #c678dd);
        border-radius: 10px;
      }

      /* Notifications List */
      .notification {
        background: rgba(30, 30, 40, 0.7);
        border-radius: 14px;
        border: 1px solid rgba(255, 255, 255, 0.08);
        margin: 8px;
        padding: 14px;
        transition: transform 0.2s ease;
      }

      .notification:hover {
        background: rgba(40, 40, 50, 0.9);
        transform: translateY(-2px);
      }

      .summary {
        font-size: 15px;
        font-weight: 700;
        color: #61afef;
      }

      .body {
        color: #dcd7ba;
        line-height: 1.4;
      }

      /* Headers/Titles */
      .widget-title {
        color: #ffffff;
        font-weight: 800;
        font-size: 20px;
        margin-bottom: 10px;
      }

      .widget-title > button {
        background: rgba(224, 108, 117, 0.15);
        color: #e06c75;
        border-radius: 10px;
        padding: 6px 14px;
        font-weight: bold;
      }

      .widget-title > button:hover {
        background: #e06c75;
        color: #ffffff;
      }

      /* Buttons & Badges */
      .close-button {
        background: rgba(224, 108, 117, 0.1);
        color: #e06c75;
        border-radius: 8px;
        padding: 2px 8px;
      }

      /* Custom Toggles (DND) */
      .widget-dnd {
        background: rgba(255, 255, 255, 0.03);
        border-radius: 12px;
        padding: 10px;
      }

      .widget-dnd switch {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 20px;
      }

      .widget-dnd switch:checked {
        background: #98c379;
      }

      .widget-dnd switch slider {
        background: #ffffff;
        border-radius: 20px;
        margin: 2px;
      }
    ''; 
  };
}

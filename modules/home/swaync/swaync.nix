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
      idle-timeout = 0;
      show-control-center = false;
      hide-on-action = true;
      hide-on-clear = true;
      notification-window-width = 400;
      popup-enabled = true;
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

# --- Custom Styling (Monochrome Polished) ---
    style = ''
      /* SwayNC - Monochrome Structural Fix & Glass UI */
      * {
all: unset;
     font-family: "JetBrainsMono Nerd Font", "Inter", sans-serif;
      }

    /* The Main Window */
    .control-center {
background: rgba(0, 0, 0, 0.85);
            border-radius: 24px;
border: 1px solid rgba(255, 255, 255, 0.08);
margin: 10px;
padding: 16px;
    }

    /* MPRIS MAIN BLOCK */
    .widget-mpris {
background: rgba(255, 255, 255, 0.06);
            border-radius: 18px;
padding: 12px;
margin: 10px;
    }

    /* Force everything to stay horizontally aligned */
    .widget-mpris-player {
background: transparent;
display: flex;
         flex-direction: row;
         align-items: center;  /* 🎯 THIS stops title from floating upward */
padding: 8px;
    }

    .widget-mpris-album-art {
      border-radius: 12px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
width: 64px;
height: 64px;
    }

    /* Container for title + subtitle + controls */
    .widget-mpris-content {
display: flex;
         flex-direction: column;
         justify-content: center; /* 👇 pulls text down to button level */
         margin-left: 15px;
         max-width: 230px; /* prevents overlapping on small widths */
    }

    .widget-mpris-title {
      font-size: 16px;
      font-weight: bold;
color: #ffffff;
       padding-bottom: 2px;
    }

    .widget-mpris-subtitle {
      font-size: 13px;
color: rgba(255, 255, 255, 0.65);
       padding-bottom: 6px;
    }

    /* Buttons */
    .widget-mpris > box > button {
background: rgba(255, 255, 255, 0.12);
            border-radius: 10px;
padding: 5px 15px;
margin: 4px;
color: white;
    }

    .widget-mpris > box > button:hover {
background: rgba(255, 255, 255, 0.22);
    }

    /* Notifications */
    .notification {
background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
border: 1px solid rgba(255, 255, 255, 0.03);
margin: 8px;
padding: 12px;
    }

    .notification-content {
margin: 5px;
    }

    .summary {
      font-weight: bold;
color: #fff;
       font-size: 15px;
    }

    .body {
color: rgba(255, 255, 255, 0.75);
       font-size: 13px;
    }

    /* Widget Titles */
    .widget-title {
color: white;
       font-size: 20px;
       font-weight: bold;
padding: 10px;
    }

    .widget-title > button {
background: rgba(255, 255, 255, 0.12);
color: #fff;
       border-radius: 10px;
padding: 5px 15px;
    }

    /* DND Widget */
    .widget-dnd {
background: rgba(255, 255, 255, 0.04);
            border-radius: 15px;
padding: 10px;
margin: 10px;
    }

    /* Scrollbar */
    scrollbar trough {
background: transparent;
    }

    scrollbar slider {
background: rgba(255, 255, 255, 0.12);
            border-radius: 10px;
    }
    '';
  };
}


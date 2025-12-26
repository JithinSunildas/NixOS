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
      /* Global Reset */
      * {
all: unset;
     font-family: "JetBrainsMono Nerd Font", "Inter", sans-serif;
      }

    /* =======================
       CONTROL CENTER (PANEL)
       ======================= */
    .control-center {
            border-radius: 24px;
padding: 16px;
margin: 10px;
        backdrop-filter: blur(12px);
    }

    /* =======================
       POP-UP NOTIFICATIONS
       ======================= */
    window.notification-popup {
            border-radius: 16px;
padding: 12px;
margin: 10px;
        min-width: 350px;
        max-width: 450px;
        backdrop-filter: blur(12px);
    }

    window.notification-popup > * {
margin: 0;
padding: 0;
    }

    .popup-notification {
display: flex;
         align-items: flex-start;
gap: 10px;
    }

    .popup-title {
      font-size: 15px;
      font-weight: bold;
      padding-bottom: 2px;
      text-overflow: ellipsis;
overflow: hidden;
          white-space: nowrap;
    }

    .popup-body {
      font-size: 13px;
      text-overflow: ellipsis;
overflow: hidden;
          white-space: nowrap;
    }

    .popup-image {
      border-radius: 12px;
      min-width: 48px;
      min-height: 48px;
    }

    /* =======================
       NOTIFICATIONS LIST
       ======================= */
    .notification {
            border-radius: 16px;
margin: 8px;
padding: 12px;
display: flex;
gap: 10px;
    }

    .summary {
      font-weight: bold;
      font-size: 15px;
      word-wrap: break-word;
    }

    .body {
      font-size: 13px;
      word-wrap: break-word;
    }

    /* =======================
       MPRIS WIDGET
       ======================= */
    .widget-mpris {
            border-radius: 18px;
padding: 12px;
margin: 10px;
    }

    .widget-mpris-player {
display: flex;
         align-items: center;
gap: 15px;
    }

    .widget-mpris-album-art {
      border-radius: 12px;
      min-width: 64px;
      min-height: 64px;
    }

    .widget-mpris-content {
display: flex;
         flex-direction: column;
         justify-content: center;
         min-width: 0;
    }

    .widget-mpris-title,
      .widget-mpris-subtitle {
        text-overflow: ellipsis;
overflow: hidden;
          white-space: nowrap;
margin: 0;
padding: 0;
      }

    .widget-mpris-title {
      font-weight: bold;
      font-size: 16px;
    }

    .widget-mpris-subtitle {
      font-size: 13px;
    }

    .widget-mpris button {
            border-radius: 10px;
padding: 5px 15px;
margin: 5px;
    }

    .widget-mpris button:hover {
    }

    /* =======================
       TITLES + DND
       ======================= */
    .widget-title {
      font-size: 20px;
      font-weight: bold;
padding: 10px;
    }

    .widget-title > button {
            border-radius: 10px;
padding: 5px 15px;
    }

    .widget-dnd {
            border-radius: 15px;
padding: 10px;
margin: 10px;
    }

    /* =======================
       SCROLLBARS
       ======================= */
    scrollbar trough {
background: transparent;
    }
    scrollbar slider {
            border-radius: 10px;
    }
    '';
  };
}


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
  };
}


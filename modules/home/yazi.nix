{ ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;

    settings = {
      manager = {
        # Layout
        layout = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = false;
        show_symlink = true;

        # Scrolling
        scrolloff = 5;

        # Preview
        ratio = [
          1
          2
          3
        ];
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
      };

      opener = {
        # Text files
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
            for = "unix";
          }
        ];

        # Images
        image = [
          {
            run = ''imv "$@"'';
            orphan = true;
            for = "unix";
          }
        ];

        # Videos
        video = [
          {
            run = ''mpv "$@"'';
            orphan = true;
            for = "unix";
          }
        ];

        # PDFs
        pdf = [
          {
            run = ''okular "$@"'';
            orphan = true;
            for = "unix";
          }
        ];

        # Archives
        archive = [
          {
            run = ''file-roller "$@"'';
            orphan = true;
            for = "unix";
          }
        ];
      };

      open = {
        rules = [
          {
            mime = "text/*";
            use = "edit";
          }
          {
            mime = "image/*";
            use = "image";
          }
          {
            mime = "video/*";
            use = "video";
          }
          {
            mime = "application/pdf";
            use = "pdf";
          }
          {
            mime = "application/*zip";
            use = "archive";
          }
          {
            mime = "application/x-tar";
            use = "archive";
          }
          {
            mime = "application/x-bzip2";
            use = "archive";
          }
          {
            mime = "application/x-7z-compressed";
            use = "archive";
          }
          {
            mime = "application/x-rar";
            use = "archive";
          }
        ];
      };
    };

    # Keybindings
    keymap = {
      manager.prepend_keymap = [
        # Navigation
        {
          on = [ "h" ];
          run = "leave";
          desc = "Go back";
        }
        {
          on = [ "l" ];
          run = "enter";
          desc = "Enter directory";
        }
        {
          on = [ "k" ];
          run = "arrow -1";
          desc = "Move up";
        }
        {
          on = [ "j" ];
          run = "arrow 1";
          desc = "Move down";
        }

        # File operations
        {
          on = [
            "d"
            "d"
          ];
          run = "remove";
          desc = "Delete selected";
        }
        {
          on = [
            "y"
            "y"
          ];
          run = "yank";
          desc = "Yank (copy)";
        }
        {
          on = [ "p" ];
          run = "paste";
          desc = "Paste";
        }
        {
          on = [ "x" ];
          run = "remove --permanently";
          desc = "Delete permanently";
        }

        # Create/Rename
        {
          on = [ "a" ];
          run = "create";
          desc = "Create file";
        }
        {
          on = [ "A" ];
          run = "create --dir";
          desc = "Create directory";
        }
        {
          on = [ "r" ];
          run = "rename";
          desc = "Rename";
        }

        # Search and select
        {
          on = [ "/" ];
          run = "find";
          desc = "Find";
        }
        {
          on = [ "?" ];
          run = "find --previous";
          desc = "Find previous";
        }
        {
          on = [ "n" ];
          run = "find_arrow";
          desc = "Next result";
        }
        {
          on = [ "N" ];
          run = "find_arrow --previous";
          desc = "Previous result";
        }
        {
          on = [ "<Space>" ];
          run = "select --state=none";
          desc = "Toggle selection";
        }
        {
          on = [ "v" ];
          run = "visual_mode";
          desc = "Visual mode";
        }
        {
          on = [ "V" ];
          run = "visual_mode --unset";
          desc = "Exit visual mode";
        }

        # Shell and quick actions
        {
          on = [ "!" ];
          run = "shell";
          desc = "Run shell command";
        }
        {
          on = [ ":" ];
          run = "shell --block";
          desc = "Run blocking shell";
        }
        {
          on = [ ";" ];
          run = "shell --confirm";
          desc = "Run shell with confirm";
        }
        {
          on = [ "." ];
          run = "hidden toggle";
          desc = "Toggle hidden files";
        }
        {
          on = [ "s" ];
          run = "search fd";
          desc = "Search with fd";
        }

        # Sorting
        {
          on = [
            ","
            "a"
          ];
          run = "sort alphabetical --dir-first";
          desc = "Sort alphabetically";
        }
        {
          on = [
            ","
            "A"
          ];
          run = "sort alphabetical --reverse --dir-first";
          desc = "Sort alphabetically (reverse)";
        }
        {
          on = [
            ","
            "m"
          ];
          run = "sort modified --dir-first";
          desc = "Sort by modified";
        }
        {
          on = [
            ","
            "M"
          ];
          run = "sort modified --reverse --dir-first";
          desc = "Sort by modified (reverse)";
        }
        {
          on = [
            ","
            "s"
          ];
          run = "sort size --dir-first";
          desc = "Sort by size";
        }
        {
          on = [
            ","
            "S"
          ];
          run = "sort size --reverse --dir-first";
          desc = "Sort by size (reverse)";
        }

        # Tabs
        {
          on = [ "t" ];
          run = "tab_create --current";
          desc = "New tab";
        }
        {
          on = [ "T" ];
          run = "tab_close";
          desc = "Close tab";
        }
        {
          on = [ "[" ];
          run = "tab_switch -1 --relative";
          desc = "Previous tab";
        }
        {
          on = [ "]" ];
          run = "tab_switch 1 --relative";
          desc = "Next tab";
        }

        # Go to locations
        {
          on = [
            "g"
            "h"
          ];
          run = "cd ~";
          desc = "Go to home";
        }
        {
          on = [
            "g"
            "c"
          ];
          run = "cd ~/.config";
          desc = "Go to config";
        }
        {
          on = [
            "g"
            "d"
          ];
          run = "cd ~/Downloads";
          desc = "Go to downloads";
        }
        {
          on = [
            "g"
            "D"
          ];
          run = "cd ~/Documents";
          desc = "Go to documents";
        }
        {
          on = [
            "g"
            "p"
          ];
          run = "cd ~/Pictures";
          desc = "Go to pictures";
        }
        {
          on = [
            "g"
            "v"
          ];
          run = "cd ~/Videos";
          desc = "Go to videos";
        }
        {
          on = [
            "g"
            "n"
          ];
          run = "cd ~/nix-config";
          desc = "Go to nix-config";
        }
      ];

      # Input mode keybindings (for rename, create, etc.)
      input.prepend_keymap = [
        # Normal editing
        {
          on = [ "<C-h>" ];
          run = "backspace";
          desc = "Backspace";
        }
        {
          on = [ "<Backspace>" ];
          run = "backspace";
          desc = "Backspace";
        }
        {
          on = [ "<Delete>" ];
          run = "delete";
          desc = "Delete";
        }

        # Ctrl+Backspace - delete word backward
        {
          on = [ "<C-Backspace>" ];
          run = "kill --prev";
          desc = "Delete word backward";
        }
        {
          on = [ "<C-w>" ];
          run = "kill --prev";
          desc = "Delete word backward (alt)";
        }

        # Ctrl+Delete - delete word forward
        {
          on = [ "<C-Delete>" ];
          run = "delete --cut";
          desc = "Delete word forward";
        }

        # Movement
        {
          on = [ "<Left>" ];
          run = "move -1";
          desc = "Move left";
        }
        {
          on = [ "<Right>" ];
          run = "move 1";
          desc = "Move right";
        }
        {
          on = [ "<C-b>" ];
          run = "move -1";
          desc = "Move left";
        }
        {
          on = [ "<C-f>" ];
          run = "move 1";
          desc = "Move right";
        }
        {
          on = [ "<Home>" ];
          run = "move -999";
          desc = "Move to start";
        }
        {
          on = [ "<End>" ];
          run = "move 999";
          desc = "Move to end";
        }
        {
          on = [ "<C-a>" ];
          run = "move -999";
          desc = "Move to start";
        }
        {
          on = [ "<C-e>" ];
          run = "move 999";
          desc = "Move to end";
        }

        # Word movement
        {
          on = [ "<A-Left>" ];
          run = "backward";
          desc = "Move word backward";
        }
        {
          on = [ "<A-Right>" ];
          run = "forward";
          desc = "Move word forward";
        }
        {
          on = [ "<A-b>" ];
          run = "backward";
          desc = "Move word backward";
        }
        {
          on = [ "<A-f>" ];
          run = "forward";
          desc = "Move word forward";
        }

        # Delete operations
        {
          on = [ "<C-u>" ];
          run = "kill --line";
          desc = "Delete to start of line";
        }
        {
          on = [ "<C-k>" ];
          run = "kill";
          desc = "Delete to end of line";
        }

        # Submit/Cancel
        {
          on = [ "<Enter>" ];
          run = "close --submit";
          desc = "Submit";
        }
        {
          on = [ "<Esc>" ];
          run = "close";
          desc = "Cancel";
        }
        {
          on = [ "<C-c>" ];
          run = "close";
          desc = "Cancel";
        }

        # Paste
        {
          on = [ "<C-v>" ];
          run = "paste";
          desc = "Paste";
        }
      ];
    };

  };
}

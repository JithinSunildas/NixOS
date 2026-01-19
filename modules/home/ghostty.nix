{
  stylix.targets.ghostty.enable = false;

  programs.ghostty = {
    enable = true;
    settings = {
      # Visual Settings
      window-decoration = "none";
      font-size = 12;

      # Core Colors (Kanso Warmth)
      background = "#2b2b2b"; # The correct warm grey
      foreground = "#cbcbcb"; # Soft white
      cursor-color = "#d79921"; # Amber/Gold for visibility
      selection-background = "#525252";
      selection-foreground = "#cbcbcb";

      # ANSI Palette (Kanso/Gruvbox-ish Earth Tones)
      palette = [
        "0=#2b2b2b" # Black
        "1=#c5735e" # Red (Clay)
        "2=#88aa22" # Green (Moss)
        "3=#d79921" # Yellow (Gold)
        "4=#6890c0" # Blue (Faded)
        "5=#a888c8" # Magenta (Muted)
        "6=#609090" # Cyan (Teal)
        "7=#cbcbcb" # White
        "8=#525252" # Bright Black
        "9=#c5735e" # Bright Red
        "10=#88aa22" # Bright Green
        "11=#d79921" # Bright Yellow
        "12=#6890c0" # Bright Blue
        "13=#a888c8" # Bright Magenta
        "14=#609090" # Bright Cyan
        "15=#e1e1e1" # Bright White
      ];
    };
  };
}

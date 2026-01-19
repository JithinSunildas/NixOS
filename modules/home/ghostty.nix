{
  stylix.targets.ghostty.enable = false;
  programs.ghostty = {
    enable = true;
    settings = {
      # Visual Settings
      window-decoration = "none";
      font-size = 12;

      # Core Colors
      background = "#14171d";
      foreground = "#c5c9c7";
      cursor-color = "#c5c9c7";
      selection-background = "#3E424A";
      selection-foreground = "#c5c9c7";

      # ANSI Palette
      palette = [
        "0=#14171d"
        "1=#c4746e"
        "2=#8a9a7b"
        "3=#c4b28a"
        "4=#8ba4b0"
        "5=#a292a3"
        "6=#8ea4a2"
        "7=#a4a7a4"
        "8=#5C6066"
        "9=#e46876"
        "10=#87a987"
        "11=#e6c384"
        "12=#7fb4ca"
        "13=#938aa9"
        "14=#7aa89f"
        "15=#c5c9c7"
      ];
    };
  };
}

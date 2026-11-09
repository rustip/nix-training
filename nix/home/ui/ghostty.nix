{ ... }: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      theme = "Ayu Mirage";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      window-decoration = "auto";
      window-padding-x = 6;
      window-padding-y = 6;

      scrollback-limit = 10000;
    };
  };
}

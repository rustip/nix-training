{ ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    userSettings = {
      auto_save = true;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 14;
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Ayu Mirage";
      };
      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
      };
      line_numbers = true;
      cursor_blinking = true;
      languages.Nix.language_servers = [
        "nixd"
        "!nil"
      ];
      lsp.nixd.initialization_options.formatting.command = [ "nixfmt" ];
    };
  };
}

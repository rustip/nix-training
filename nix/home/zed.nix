{ ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    userSettings = {
      autosave = "on_focus_change";
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
      relative_line_numbers = "enabled";
      languages.Nix.language_servers = [
        "nixd"
        "!nil"
      ];
      lsp.nixd.initialization_options.formatting.command = [ "nixfmt" ];
    };
  };
}

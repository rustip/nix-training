{ pkgs, ... }: {
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "dev.zed.Zed.desktop"
        "google-chrome.desktop"
        "org.gnome.Nautilus.desktop"
      ];

      enabled-extensions = with pkgs.gnomeExtensions; [
        open-bar.extensionUuid
        paperwm.extensionUuid
        search-light.extensionUuid
        switcher.extensionUuid
        user-themes.extensionUuid
        windownavigator.extensionUuid
        just-perfection.extensionUuid

      ];
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:ctrl_modifier" ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "slate";
      font-antialiasing = "rgba";
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
      workspace-names = [
        "1"
        "2"
        "3"
        "4"
      ];
      resize-with-right-button = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      show-desktop = [ ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
    };

    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
      dynamic-workspaces = false;
      center-new-windows = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-d.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-d.jxl";
    };

    "org/gnome/Ptyxis" = {
      use-system-font = false;
      interface-style = "system";
      font-name = "JetBrainsMono Nerd Font 11";
      default-profile-uuid = "4d1e6d22-4b5a-4f8e-9c1a-2b3c4d5e6f7a";
    };

    "org/gnome/Ptyxis/Profiles/4d1e6d22-4b5a-4f8e-9c1a-2b3c4d5e6f7a" = {

      palette = "Catppuccin Mocha";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      # command = "ptyxis -s";
      command = "ghostty";
      binding = "<Super>Return";
    };

    "org/gnome/shell/extensions/switcher" = {
      max-width-percentage = 25;
      font-size = 16;
      icon-size = 16;
      matching = 1;
      activate-by-key = 2;
    };

    "org/gnome/shell/extensions/paperwm" = {
      show-workspace-indicator = false;
      show-window-position-bar = false;
      cycle-width-steps = [
        0.3333
        0.5
        0.6667
      ];
      selection-border-size = 5;
      window-gap = 12;
      horizontal-margin = 12;
      vertical-margin = 12;
      vertical-margin-bottom = 12;
      winprops = [
        "{\"wm_class\":\"dev.zed.Zed\",\"preferredWidth\":\"67%\"}"
        "{\"wm_class\":\"org.gnome.Ptyxis\",\"preferredWidth\":\"33%\"}"
        "{\"wm_class\":\"com.mitchellh.ghostty\",\"preferredWidth\":\"33%\"}"
        "{\"wm_class\":\"vicinae\",\"scratch_layer\":true}"
        "{\"wm_class\":\"*\",\"preferredWidth\":\"50%\"}"
      ];
    };

    "org/gnome/desktop/screensaver" = {
      restart-enabled = true;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [
        "<Super>BackSpace"
        "<Super>q"
      ];
      switch-right = [ "<Super>Right" ];
      switch-left = [ "<Super>Left" ];
      switch-up = [ "<Super>Up" ];
      switch-down = [ "<Super>Down" ];
      move-up = [ "<Shift><Super>Up" ];
      move-down = [ "<Shift><Super>Down" ];
      move-left = [ "<Shift><Super>Left" ];
      move-right = [ "<Shift><Super>Right" ];
      switch-up-workspace = [
        "<Super>Page_Up"
        "<Super><Control>Left"
      ];
      switch-down-workspace = [
        "<Super>Page_Down"
        "<Super><Control>Right"
      ];
      move-up-workspace = [
        "<Shift><Super>Page_Up"
        "<Super><Control><Shift>Left"
      ];
      move-down-workspace = [
        "<Shift><Super>Page_Down"
        "<Super><Control><Shift>Right"
      ];
      new-window = [ "<Super>n" ];
      move-monitor-above = [ ];
      move-monitor-below = [ ];
      move-monitor-left = [ ];
      move-monitor-right = [ ];
      move-space-monitor-above = [ ];
      move-space-monitor-below = [ ];
      move-space-monitor-left = [ ];
      move-space-monitor-right = [ ];
      open-window-position-down = [ ];
      open-window-position-left = [ ];
      swap-monitor-above = [ ];
      swap-monitor-below = [ ];
      swap-monitor-left = [ ];
      swap-monitor-right = [ ];
      switch-monitor-above = [ ];
      switch-monitor-below = [ ];
      switch-monitor-left = [ ];
      switch-monitor-right = [ ];
      switch-next = [ ];
      switch-previous = [ ];
    };

    "org/gnome/shell/extensions/search-light" = {
      primary-shortcut-search = [ "<Super>Space" ];
      secondary-shortcut-search = [ "<Super>d" ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      hot-keys = false;
      dash-max-icon-size = 48;
      dock-fixed = true;
    };
  };
}

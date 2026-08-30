{ pkgs, ... }: {
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.paperwm
    gnomeExtensions.user-themes
    gnomeExtensions.switcher
    gnomeExtensions.windownavigator
    ptyxis
  ];

  # services.gnome.core-apps.enable = false;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-terminal
    gnome-tour
    gnome-user-docs
  ];
}

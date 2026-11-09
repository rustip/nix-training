# Graphical apps and their settings. gnome-home.nix is opt-in (not imported).
{
  imports = [
    ./apps.nix
    ./ghostty.nix
    ./zed.nix
  ];
}

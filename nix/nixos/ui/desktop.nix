{ pkgs, vars, ... }:
{
  services.xserver.xkb.options = "caps:ctrl_modifier";

  security.rtkit.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      font-awesome
      inter
      inter-nerdfont
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
  };

  users.extraGroups.video.members = [ vars.username ];

  environment.systemPackages = with pkgs; [
    gcr
    google-chrome
    libsecret
    udiskie
    udisks2
    wl-clipboard
  ];
}

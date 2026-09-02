{ pkgs, vars, ... }: {
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;

  services.xserver.xkb.options = "caps:ctrl_modifier";

  security.rtkit.enable = true;
  security.polkit.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;

  services.gnome.gnome-keyring.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
    };
  };

  services.openssh.enable = true;

  programs.nix-ld.enable = true;
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

  programs.neovim.enable = true;
  programs.fish.enable = true;

  services.passSecretService.enable = true;

  environment.systemPackages = with pkgs; [
    cmake
    curl
    gcc
    gcr
    git
    gnumake
    google-chrome
    libsecret
    lsof
    pstree
    udiskie
    udisks2
    uv
    unzip
    wget
    wl-clipboard
  ];
}

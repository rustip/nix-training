{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      extra-substituters = [ "https://cache.numtide.com" ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
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
  programs.neovim.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    cmake
    curl
    gcc
    git
    gnumake
    lsof
    pstree
    uv
    unzip
    wget
  ];
}

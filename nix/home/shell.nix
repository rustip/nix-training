{ ... }:
let
  shellAliases = {
    l = "eza";
    ll = "eza -l";
    la = "eza -la";
    lt = "eza --tree";
    gst = "git status";
    gcm = "git commit -m";
    gp = "git push";
    gfm = "git pull";
    gia = "git add .";
    gcb = "git checkout -b";
    gcan = "git commit --amend --no-edit";
    nrs = "sudo nixos-rebuild switch --flake path:.#";
    zed = "zeditor";
    fps = "flatpak search";
    fpr = "flatpak run";
    fpi = "flatpak install -y --user flathub";
  };
in
{
  programs = {
    bash = {
      enable = true;
      inherit shellAliases;
    };
    nushell = {
      enable = true;
    };

    fish = {
      enable = true;
      inherit shellAliases;
    };

    eza = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      icons = "auto";
    };

    starship = {
      enable = true;
      enableInteractive = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    carapace = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    atuin = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    home-manager.enable = true;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.opencode/bin"
    "$HOME/.codex/bin"
    "$HOME/.nix-config/scripts"
  ];
}

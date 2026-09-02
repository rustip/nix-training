{ vars, pkgs, ... }: {
  home.sessionPath = [
    "$HOME/.opencode/bin"
  ];
  imports = [
    ./ghostty.nix
    ./zed.nix
    ./shell.nix
    ./local.nix
  ];
  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bat
    btop
    delta
    devbox
    devenv
    fd
    file
    gdu
    gh
    ghostty
    htop
    imagemagick
    jq
    just
    lazygit
    luarocks
    mermaid-cli
    newt
    nil
    nixd
    nixfmt
    p7zip
    pciutils
    procs
    ripgrep
    runme
    sd
    shellcheck
    shfmt
    stow
    tealdeer
    tmux
    trash-cli
    tree
    tree-sitter
    xh
    yq
  ];
}

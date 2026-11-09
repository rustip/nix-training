{
  vars,
  pkgs,
  inputs,
  ...
}:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.sessionPath = [
    "$HOME/.opencode/bin"
  ];
  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;
  home.stateVersion = "26.05";

  home.packages =
    with pkgs;
    [
      bat
      btop
      delta
      devbox
      devcontainer
      devenv
      fd
      file
      gdu
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
    ]
    ++ (with llm-agents; [
      claude-code
      codex
    ]);
}

{
  vars,
  pkgs,
  inputs,
  ...
}:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};

  # The 2.x binary is named `opencode2`; expose it as `opencode`.
  opencode = pkgs.runCommand "opencode" { } ''
    install -Dm555 ${llm-agents.opencode2}/bin/opencode2 $out/bin/opencode
  '';
in
{
  home.sessionPath = [
    "$HOME/.opencode/bin"
  ];
  home.username = vars.username;
  home.homeDirectory = vars.homeDirectory;
  home.stateVersion = "26.05";

  home.packages =
    (with pkgs; [
      bat
      btop
      delta
      devbox
      devcontainer
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
    ])
    ++ [
      pkgs-unstable.devenv
    ]
    ++ (with llm-agents; [
      claude-code
      codex
    ])
    ++ [ opencode ];
}

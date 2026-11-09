{ pkgs, ... }:
{
  # https://devenv.sh/languages/#rust
  languages.rust = {
    enable = true;
    channel = "stable"; # or "nightly" / "beta" (via rust-overlay)
    components = [
      "rustc"
      "cargo"
      "clippy"
      "rustfmt"
      "rust-analyzer"
      "rust-src"
    ];
  };

  # Writes .devcontainer.json on `devenv shell`, so VS Code / `devcontainer up`
  # can open this project in a container running the same devenv shell.
  devcontainer.enable = true;

  packages = with pkgs; [
    cargo-watch
  ];

  scripts = {
    build.exec = "cargo build";
    run.exec = "cargo run";
    lint.exec = "cargo clippy -- -D warnings";
  };

  enterShell = ''
    rustc --version
    cargo --version
  '';

  enterTest = ''
    cargo fmt --check
    cargo clippy -- -D warnings
    cargo test
  '';

  git-hooks.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
  };
}

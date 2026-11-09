{ pkgs, ... }:
{
  # https://devenv.sh/languages/rust/
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

    # Faster linking: mold on Linux, lld on macOS.
    mold.enable = pkgs.stdenv.hostPlatform.isLinux;
    lld.enable = pkgs.stdenv.hostPlatform.isDarwin;
  };

  # Writes .devcontainer.json on `devenv shell`, so VS Code / `devcontainer up`
  # can open this project in a container running the same devenv shell.
  devcontainer.enable = true;
  devcontainer.settings.customizations.vscode.extensions = [ ];

  packages = with pkgs; [
    cargo-watch
  ];

  scripts = {
    build.exec = "cargo build";
    run.exec = "cargo run";
    lint.exec = "cargo clippy -- -D warnings";
  };

  # Print toolchain versions on shell startup.
  # https://devenv.sh/tasks/#entershell--entertest
  tasks."rust:versions" = {
    exec = ''
      rustc --version
      cargo --version
    '';
    before = [ "devenv:enterShell" ];
  };

  # fmt, clippy and tests run as tasks before `devenv:enterTest` (`devenv test`).
  tasks = {
    "rust:fmt-check" = {
      exec = "cargo fmt --check";
      before = [ "devenv:enterTest" ];
    };
    "rust:clippy" = {
      exec = "cargo clippy -- -D warnings";
      before = [ "devenv:enterTest" ];
    };
    "rust:test" = {
      exec = "cargo test";
      before = [ "devenv:enterTest" ];
    };
  };

  git-hooks.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
  };
}

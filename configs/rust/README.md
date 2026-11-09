# Rust devenv template

Copy this folder to start a Rust project with a [devenv](https://devenv.sh) shell:

```bash
cp -r ~/.nix-config/configs/rust ~/my-project && cd ~/my-project
devenv shell      # or `direnv allow` to load the shell automatically on cd
cargo run
```

The shell provides the stable Rust toolchain (rustc, cargo, clippy, rustfmt, rust-analyzer, rust-src) through rust-overlay, plus `cargo-watch`.

- `build`, `run` and `lint` are shortcuts for `cargo build`, `cargo run` and `cargo clippy`.
- `devenv test` runs the formatting check, clippy and the tests.
- rustfmt and clippy run as git hooks once the project is a git repository.

## Devcontainer

`devcontainer.enable = true` in `devenv.nix` makes devenv write `.devcontainer/devcontainer.json`. That file is committed too, so editors can find it before devenv has ever run. The container uses the `ghcr.io/cachix/devenv/devcontainer` image, runs this same devenv shell, and runs `devenv test` when it's created. It needs Docker on the host (`nix/nixos/cli/docker.nix`).

```bash
devcontainer up --workspace-folder .
devcontainer exec --workspace-folder . devenv shell -- cargo run
```

In VS Code, use "Dev Containers: Reopen in Container". Zed also reads the file.

## Toolchain

To change the toolchain, set `channel` in `devenv.nix`, or add `version = "1.xx.0"` to pin a specific release. Rename the package in `Cargo.toml`.

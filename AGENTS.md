# Agent Instructions

## Rules

- Never edit `configuration.nix` or `hardware-configuration.nix` or `vars.nix`.
- Agents must use `pkexec` instead of `sudo` when directly running privileged commands so the user can enter their password through a GUI dialog. Using `sudo` in scripts or commands intended for the user to run is fine.

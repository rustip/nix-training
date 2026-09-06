# Manual Setup

If you prefer to set up manually instead of using the bootstrap script, clone the repository to `~/.nix-config` and run:

```bash
sudo cp /etc/nixos/hardware-configuration.nix ~/.nix-config/hardware-configuration.nix
sudo cp /etc/nixos/configuration.nix ~/.nix-config/configuration.nix
```

Generate `vars.nix` with your user details, then rebuild.

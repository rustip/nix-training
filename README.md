# Nix Config

NixOS flake-based configuration including Home Manager.

## New Machine Setup

Use the [NixOS graphical ISO](https://channels.nixos.org/nixos-26.05/latest-nixos-graphical-x86_64-linux.iso) to install NixOS. Its installer (Calamares) is similar to other Linux distributions.

Make the following selections.

- In the boot loader menu, select the latest kernel and **not** the LTS.
- During installation, check 'allow unfree software'.
- Pick 'gnome' as your desktop environment.

Once installed, reboot and log in.

**IMPORTANT NOTE**: The current OS state (a snapshot) will be saved, and if anything goes wrong, you can go back to this state from your boot loader menu.

Open a terminal (TTY or GNOME Terminal) and run the following.
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rustip/nix-training/main/scripts/bootstrap)"
```

This will:
1. Clone the repository to `~/.nix-config`
2. Generate `vars.nix` with your username, home directory, and hostname
3. Copy your hardware and system configuration files from `/etc/nixos`
4. Prompt you to rebuild the system

### Manual Setup

See [docs/manual.md](docs/manual.md).

### Adding Packages

Edit `nix/home/home.nix` for user packages or `nix/nixos/core.nix` for system packages.

You can also add your own Nix code to `nix/home/local.nix` for Home Manager config and to `nix/nixos/local.nix` for NixOS config.

### Locale Setup

See [Locale Setup](docs/locale.md) to configure `en_US.UTF-8` and apply the settings.

### Changing Hostname

The hostname is set in two places:

1. `hostname` in `nix/vars.nix` — also names the flake output (`nixosConfigurations.<hostname>`)
2. `networking.hostName` in `nix/host/configuration.nix`

Update both to the new hostname, then rebuild with the new name (the bare `path:.#` uses the *current* hostname, which no longer matches a flake output):

```bash
sudo nixos-rebuild switch --flake path:.#<new-hostname>
```

Reboot your PC.

### Zed Editor

Zed is installed and configured declaratively via Home Manager's `programs.zed-editor` module in `nix/home/zed.nix`.

Home Manager generates `~/.config/zed/settings.json` from the `userSettings` attribute set on every rebuild, so any manual edits you make to that file **will be overwritten**. Do not edit it directly. Instead, edit `userSettings` in `nix/home/zed.nix` and rebuild.


### Rebuilding / Updating NixOS

After making any changes to the configuration files, rebuild and apply (preferably in a TTY):

```bash
sudo nixos-rebuild switch --flake path:.#
```

Reboot your PC. This is necessary.

### GitHub SSH Setup

See [GitHub SSH Setup](docs/github-ssh.md) to authenticate with an SSH key and configure repository remotes.

### Using with Your Own Repository

After initial setup, you may want to use this configuration with your own GitHub repository:

```bash
# Remove the original git history
rm -rf .git

# Login to GitHub CLI
gh auth login

# Create a new public repository
gh repo create nix-config --public --source=. --push
```

### AI Tools

See [docs/ai-tools.md](docs/ai-tools.md).

### Dev Containers

#### box

See [docs/box.md](docs/box.md).

#### pod

See [docs/pod.md](docs/pod.md).

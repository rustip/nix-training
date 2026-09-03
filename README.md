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

**Note**: You can just point your AI agent (Claude/Codex) to this README, and it should do everything for you.

If you don't want to run the above script, or it does not work for your system, you can set up your system manually.

```bash
git clone https://github.com/rustip/nix-training.git ~/.nix-config
cd ~/.nix-config
mkdir -p nix/host
cp /etc/nixos/* nix/host/
```

Create and edit `nix/vars.nix` in `~/.nix-config` with your username, home directory, and hostname. It should look like this:

```nix
{
  username = "your_username";
  homeDirectory = "/home/your_username";
  hostname = "your_hostname"; # on a freshly installed NixOS system, the hostname is typically `nixos`
}
```

`vars.nix` is useful for keeping Nix evaluations pure.

Machine-specific files are intentionally ignored by Git. Use the explicit `path:` flake reference below so Nix includes them without staging or committing them.

Rebuild the system

```bash
sudo nixos-rebuild switch --flake path:.#
```

### Adding Packages

Edit `nix/home/home.nix` for user packages or `nix/nixos/core.nix` for system packages.

You can also add your own Nix code to `nix/home/local.nix` for Home Manager config and to `nix/nixos/local.nix` for NixOS config.

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

Install your AI tools the conventional way. These update often, so NixOS packages might not be the best solution.

Opencode
```bash
curl -fsSL https://opencode.ai/install | bash
```

Codex

ignore the error message about `.bashrc`
```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

Claude Code
```
curl -fsSL https://claude.ai/install.sh | bash
```

### Dev Containers

There are two helper scripts in `scripts/` (already on your `PATH` after rebuild): `box` for integrated Ubuntu dev environments via [distrobox](https://distrobox.it/), and `pod` for grouped containers via [podman pods](https://docs.podman.io/en/latest/markdown/podman-pod.1.html).

#### box

Creates Ubuntu 26.04 [distrobox](https://distrobox.it/) containers with an init system, a per-box home at `~/.boxes/<name>`, its own hostname, and a clean `PATH` on enter.

```bash
box create mydev    # create (ubuntu:26.04, init, ~/.boxes/mydev) and enter it
box enter mydev     # enter again (fzf picker if name omitted)
box list            # list boxes
box rm mydev        # remove box (fzf picker if name omitted)
```

Inside a box you get your host user, files, and flatpak/GUI app access — see the [distrobox docs](https://distrobox.it/) for details. Packages installed inside (`apt install ...`) persist in that box's home/container.

#### box-setup

Provisions a box from the host: adds extra apt sources, installs apps from the newest `.deb` in a repo's Packages index (e.g. Claude Desktop), installs local `.deb` files (staged through `/tmp` to avoid apt sandbox notices), and installs extra apt packages. Configure what it does in the arrays at the top of `scripts/box-setup`.

```bash
box-setup dev                                        # apply configured setup to box 'dev'
box-setup dev ~/Downloads/chatgpt_amd64.deb          # also install a local .deb
box-setup                                            # pick box with fzf
```

Running it again is safe; every step is idempotent.

#### pod

Kubectl-style workflow over [podman pods](https://docs.podman.io/en/latest/markdown/podman-pod.1.html) — groups of containers sharing a network namespace, useful for running a dev stack (app + db + cache).

```bash
pod new dev -p 8080:80                  # create pod, publish ports (args pass to podman)
pod run dev docker.io/library/nginx:stable   # add a container (auto-named dev-nginx)
pod run dev docker.io/library/postgres:18
pod ps                                 # list pods
pod logs dev nginx -f                   # follow logs (fzf pickers when names omitted)
pod sh dev                              # shell into a container
pod stop dev && pod rm dev              # teardown
```

See the official docs for more: [podman run](https://docs.podman.io/en/latest/markdown/podman-run.1.html), [podman pod create](https://docs.podman.io/en/latest/markdown/podman-pod-create.1.html).

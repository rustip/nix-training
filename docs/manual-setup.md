# Manual Setup

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

# Test VM

A headless QEMU VM for testing config changes before you run `nixos-rebuild switch`. It boots only the CLI half of the config: `nix/nixos/cli` and `nix/home/cli`. It leaves out the `ui/` modules, GNOME, `nix/nixos/hardware.nix` and your host files.

It doesn't need `nix/vars.nix`. The VM user is `nixos`, with password `nixos`. The user is in the `wheel` and `docker` groups, and is a trusted Nix user (devenv needs that).

## Start

From the repo root:

```bash
nix run path:.#vm
```

The console runs in your terminal and logs you in automatically. Press `Ctrl-a x` to power the VM off, or run `sudo poweroff` in the VM.

## SSH from the host

```bash
ssh -p 2222 nixos@localhost
```

The password is `nixos`. If you rebuild and the host key changes, run `ssh-keygen -R "[localhost]:2222"`.

## State

The VM's disk is saved to `nixos-vm.qcow2` in the directory you ran it from (it is gitignored). Docker images and anything Nix builds inside the VM are kept there. Delete the file to start from a clean VM.

The host's Nix store is shared into the VM, so config changes take effect the next time you run `nix run`.

## Differences from the host

`nix/vm/default.nix` changes a few settings for the VM:

- `auto-optimise-store` and automatic garbage collection are off. Hard-linking fails on the VM's overlay store and breaks devenv.
- The VM's writable store is on disk instead of in RAM.

## Settings

Memory (4 GB), CPU count (4), disk size (20 GB) and forwarded ports are set in `nix/vm/default.nix`.

# Headless QEMU VM for testing the CLI config (nix/nixos/cli + nix/home/cli)
# without touching the real machine. No ui/ modules, no hardware config.
#
#   nix run path:.#vm           # boots in this terminal (serial console)
#   ssh -p 2222 <user>@localhost
{
  lib,
  modulesPath,
  pkgs,
  vars,
  ...
}:
{
  imports = [ "${modulesPath}/virtualisation/qemu-vm.nix" ];

  networking.hostName = vars.hostname;
  system.stateVersion = "26.05";

  virtualisation = {
    graphics = false; # console on the terminal you ran it from
    memorySize = 4096; # MiB
    cores = 4;
    diskSize = 20480; # MiB
    # Store paths built in the VM (e.g. devenv shells) go to disk, not RAM.
    writableStoreUseTmpfs = false;
    forwardPorts = [
      {
        from = "host";
        host.port = 2222;
        guest.port = 22;
      }
    ];
  };

  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;
  services.getty.autologinUser = vars.username;

  services.openssh.settings.PasswordAuthentication = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # The VM store is an overlay on the host's 9p-shared store; hard-linking
  # across it fails ("linking ... to /nix/store/.links/..."), breaking devenv.
  nix.settings.auto-optimise-store = lib.mkForce false;
  nix.gc.automatic = lib.mkForce false;
  # Mirror the host, where the user is a trusted Nix user (devenv needs it).
  nix.settings.trusted-users = [ vars.username ];
}

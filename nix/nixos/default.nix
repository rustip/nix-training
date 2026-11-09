# Full NixOS config for the real machine. The test VM imports ./cli only.
{
  imports = [
    ./cli
    ./ui
    ./hardware.nix
    ./local.nix
  ];
}

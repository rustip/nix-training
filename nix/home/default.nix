# Full Home Manager config for the real machine. The test VM imports ./cli only.
{
  imports = [
    ./cli
    ./ui
    ./local.nix
  ];
}

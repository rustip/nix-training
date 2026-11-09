# Headless system config: safe on servers and the test VM.
{
  imports = [
    ./core.nix
    ./distrobox.nix
    ./docker.nix
  ];
}

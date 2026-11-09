# Shared Home Manager settings. Which modules the user gets is chosen in
# flake.nix (full ./home on the host, ./home/cli in the test VM).
{ vars, inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit vars inputs; };
  };
}

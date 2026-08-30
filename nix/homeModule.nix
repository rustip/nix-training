{ vars, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit vars; };

    users.${vars.username} = {
      imports = [ ./home ];
    };
  };
}

{
  description = "NixOS flake configuration";

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Intentionally not following our nixpkgs so the numtide binary cache hits.
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # nixosModules: system modules; homeModules: what the user's Home Manager imports.
      mkSystem =
        {
          vars,
          nixosModules,
          homeModules,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit vars inputs; };
          modules = nixosModules ++ [
            home-manager.nixosModules.home-manager
            ./nix/homeModule.nix
            { home-manager.users.${vars.username}.imports = homeModules; }
          ];
        };

      # Real machine (cli + ui): needs the untracked nix/vars.nix and nix/host/configuration.nix.
      host =
        let
          vars = import ./nix/vars.nix;
        in
        {
          ${vars.hostname} = mkSystem {
            inherit vars;
            nixosModules = [
              ./nix/host
              ./nix/nixos
            ];
            homeModules = [ ./nix/home ];
          };
        };

      # Headless test VM (cli only): self-contained, does not need vars.nix or host files.
      vmVars = {
        username = "nixos";
        homeDirectory = "/home/nixos";
        hostname = "nixos-vm";
      };
    in
    {
      nixosConfigurations = (if builtins.pathExists ./nix/vars.nix then host else { }) // {
        vm = mkSystem {
          vars = vmVars;
          nixosModules = [
            ./nix/vm
            ./nix/nixos/cli
          ];
          homeModules = [ ./nix/home/cli ];
        };
      };

      apps.${system}.vm = {
        type = "app";
        program = "${self.nixosConfigurations.vm.config.system.build.vm}/bin/run-${vmVars.hostname}-vm";
      };
    };
}

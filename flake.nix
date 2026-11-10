{
  description = "My shiny new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      systemLinux = "x86_64-linux";
      systemDarwin = "aarch64-darwin";

      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      makeHome =
        {
          system,
          username,
          homeDirectory,
        }:

        home-manager.lib.homeManagerConfiguration {

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            (
              { ... }:
              {
                home.username = username;
                home.homeDirectory = homeDirectory;

                # NOTE: Don't change!
                home.stateVersion = "26.11";
              }
            )

            ./home
          ];
        };
    in
    {
      lib = {
        inherit
          systemLinux
          systemDarwin
          ;
      };

      homeManagerModules.default = ./home;

      homeConfigurations = {
        linux = makeHome {
          system = systemLinux;
          username = "vidd";
          homeDirectory = "/home/vidd";
        };

        darwin = makeHome {
          system = systemDarwin;
          username = "vidd";
          homeDirectory = "/Users/vidd";
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}

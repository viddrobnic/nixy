{
  description = "My shiny new nix config";

  inputs = {
    nixpkgs-linux.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };
  };

  outputs =
    {
      nixpkgs-linux,
      nixpkgs-darwin,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      systemLinux = "x86_64-linux";
      systemDarwin = "aarch64-darwin";

      makePkgs =
        system:
        let
          nixpkgs = if system == systemDarwin then nixpkgs-darwin else nixpkgs-linux;
        in
        import nixpkgs {
          inherit system;

          config.allowUnfree = true;
        };

      makePkgsUnstable =
        system:
        import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      forAllSystems = nixpkgs-unstable.lib.genAttrs nixpkgs-unstable.lib.systems.flakeExposed;

      makeHome =
        {
          system,
          username,
          homeDirectory,
          extraModules ? [ ],
        }:

        home-manager.lib.homeManagerConfiguration {
          pkgs = makePkgs system;

          modules = [
            (
              { ... }:
              {
                home.username = username;
                home.homeDirectory = homeDirectory;
              }
            )

            ./home
          ]
          ++ extraModules;

          extraSpecialArgs = {
            pkgsUnstable = makePkgsUnstable system;
          };
        };
    in
    {
      homeConfigurations.linux = makeHome {
        system = systemLinux;
        username = "vidd";
        homeDirectory = "/home/vidd";

        extraModules = [ ./linux-graphics.nix ];
      };

      homeConfigurations.darwin = makeHome {
        system = systemDarwin;
        username = "vidd";
        homeDirectory = "/Users/vidd";
      };

      formatter = forAllSystems (system: nixpkgs-unstable.legacyPackages.${system}.nixfmt-tree);
    };
}

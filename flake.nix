{
  description = "My shiny new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      rust-overlay,
      home-manager,
      ...
    }:
    let
      systemLinux = "x86_64-linux";
      systemDarwin = "aarch64-darwin";

      makePkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];

          config.allowUnfree = true;
        };

      # Disable check phase for direnv on darwin...
      # overlays = [
      #   (final: prev: {
      #     direnv = prev.direnv.overrideAttrs (old: {
      #       doCheck = !prev.stdenv.hostPlatform.isDarwin;
      #     });
      #   })
      # ];

      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

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
        };
    in
    {
      # Lib is used by private configs that extend this configuration
      lib = {
        inherit
          systemLinux
          systemDarwin
          makePkgs
          makeHome
          ;
      };

      homeConfigurations.linux = makeHome {
        system = systemLinux;
        username = "vidd";
        homeDirectory = "/home/vidd";
      };

      homeConfigurations.darwin = makeHome {
        system = systemDarwin;
        username = "vidd";
        homeDirectory = "/Users/vidd";
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}

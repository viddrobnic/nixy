{
  description = "My shiny new nix config";

  inputs = {
    nixpkgs-linux.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };

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
      rust-overlay,
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
          overlays = [ rust-overlay.overlays.default ];

          config.allowUnfree = true;
        };

      makePkgsUnstable =
        system:
        import nixpkgs-unstable {
          inherit system;

          # Disable check phase for direnv on darwin...
          overlays = [
            (final: prev: {
              direnv = prev.direnv.overrideAttrs (old: {
                doCheck = !prev.stdenv.hostPlatform.isDarwin;
              });
            })
          ];

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
      # Lib is used by private configs that extend this configuration
      lib = {
        inherit
          systemLinux
          systemDarwin
          makePkgs
          makePkgsUnstable
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

      formatter = forAllSystems (system: nixpkgs-unstable.legacyPackages.${system}.nixfmt-tree);
    };
}

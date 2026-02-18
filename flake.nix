{
  description = "My shiny new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      linuxSystem = "x86_64-linux";

      pkgs = import nixpkgs {
        system = linuxSystem;
        config.allowUnfree = true;
      };
      pkgsUnstable = import nixpkgs-unstable {
        system = linuxSystem;
        config.allowUnfree = true;
      };

      forAllSystems = nixpkgs-unstable.lib.genAttrs nixpkgs-unstable.lib.systems.flakeExposed;
    in
    {
      homeConfigurations."default" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          (
            { ... }:
            {
              home.username = "vidd";
              home.homeDirectory = "/home/vidd";
            }
          )

          ./home.nix
          ./linux-graphics.nix
        ];

        extraSpecialArgs = {
          inherit pkgsUnstable;
        };
      };

      formatter = forAllSystems (system: nixpkgs-unstable.legacyPackages.${system}.nixfmt-tree);
    };
}

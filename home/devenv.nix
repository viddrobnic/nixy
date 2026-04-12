# Install some packages used for dev that are used as fallback
# for projects not yet migrated to nix

{ pkgs, pkgsUnstable, ... }:
let
  rust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
      "llvm-tools"
    ];
  };
in
{
  home.packages = [
    rust
    pkgs.nodejs_24
    pkgsUnstable.bun
  ];
}

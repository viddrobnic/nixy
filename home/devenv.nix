# Project environment integration and fallback toolchains for projects that do
# not provide their own Nix development shell yet.
{ pkgs, ... }:
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
    pkgs.nodejs_26
    pkgs.bun

    pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter
    pkgs.wrangler
  ];

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };
}

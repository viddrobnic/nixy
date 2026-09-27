# Project environment integration and fallback toolchains for projects that do
# not provide their own Nix development shell yet.
{ pkgs, ... }:
{
  home.packages = [
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.clippy
    pkgs.rust-analyzer
    pkgs.llvmPackages.llvm

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

# Project environment integration and fallback toolchains for projects that do
# not provide their own Nix development shell yet.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    cargo-audit
    llvmPackages.llvm

    nodejs_26
    bun

    defaultBeam.erlang
    defaultBeam.elixir

    vscode-extensions.vadimcn.vscode-lldb.adapter
    wrangler
  ];

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };
}

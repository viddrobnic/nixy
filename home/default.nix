{ ... }:
{
  # NOTE: Don't change!
  home.stateVersion = "25.11";

  imports = [
    ./cli.nix
    ./shell.nix
    ./version-control.nix
    ./neovim.nix
    ./coding-agents.nix
    ./devenv.nix
    ./ssh.nix
  ];

  home.file = {
    ".config/ghostty/config".source = ../dotfiles/ghostty;
  };

  programs.home-manager.enable = true;
}

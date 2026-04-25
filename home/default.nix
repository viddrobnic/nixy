{
  pkgs,
  pkgsUnstable,
  ...
}:

{
  # NOTE: Don't change!
  home.stateVersion = "25.11";

  imports = [
    ./shell.nix
    ./jujutsu.nix
    ./neovim.nix
    ./opencode.nix
    ./devenv.nix
    ./ssh.nix
  ];

  home.packages = [
    pkgs.ripgrep
    pkgs.difftastic
    pkgs.git
    pkgs.ouch
    pkgs.age

    pkgsUnstable.tree-sitter
    pkgsUnstable.nixos-rebuild-ng
  ];

  home.file = {
    ".config/ghostty/config".source = ../dotfiles/ghostty;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "auto";
      theme-dark = "gruvbox-dark";
      theme-light = "gruvbox-light";
    };
  };

  programs.direnv = {
    # TODO: Remove unstable package override.
    # We use unstable package because stable one doesn't build on darwin:
    # https://github.com/NixOS/nixpkgs/issues/507531
    package = pkgsUnstable.direnv;

    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark_v2";
      vim_keys = true;
      update_ms = 1000;
    };
  };

  programs.home-manager.enable = true;
}

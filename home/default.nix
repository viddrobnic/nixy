{
  config,
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
  ];

  home.packages = [
    pkgs.ripgrep
    pkgs.bat
    pkgs.difftastic
  ];

  home.file = {
    ".config/ghostty/config".source = ../dotfiles/ghostty;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.home-manager.enable = true;
}

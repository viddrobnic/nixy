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
    pkgs.difftastic
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.home-manager.enable = true;
}

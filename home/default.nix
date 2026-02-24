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
  ];

  home.packages = [
    pkgs.ripgrep
    pkgs.difftastic
    pkgs.git

    pkgsUnstable.tree-sitter
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

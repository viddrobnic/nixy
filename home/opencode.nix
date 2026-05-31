{ pkgsUnstable, ... }:
{
  programs.opencode = {
    enable = true;
    package = pkgsUnstable.opencode;

    themes = {
      "gruvbox-custom" = ../dotfiles/opencode-theme.json;
    };

    tui = {
      theme = "gruvbox-custom";
    };
  };
}

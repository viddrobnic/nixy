{ pkgsUnstable, ... }:
{
  programs.opencode = {
    enable = true;
    package = pkgsUnstable.opencode;

    themes = {
      "gruvbox-custom" = ../dotfiles/opencode-theme.json;
    };

    settings = {
      theme = "gruvbox-custom";
    };
  };
}

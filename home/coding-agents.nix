{ ... }:
{
  programs.opencode = {
    enable = true;

    themes = {
      "gruvbox-custom" = ../dotfiles/opencode-theme.json;
    };

    tui = {
      theme = "gruvbox-custom";
    };
  };

  programs.codex.enable = true;
}

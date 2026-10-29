{ ... }:
{
  programs.opencode = {
    enable = true;

    themes = {
      "gruvbox-custom" = ../dotfiles/opencode-theme.json;
    };

    cli = {
      theme.name = "gruvbox-custom";
      tabs.mode = "off";
    };
  };

  programs.codex.enable = true;

  home.shellAliases = {
    oc = "opencode";
  };
}

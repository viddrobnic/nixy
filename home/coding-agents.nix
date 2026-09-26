{ llm-agents, ... }:
{
  programs.opencode = {
    enable = true;
    package = llm-agents.opencode2;

    themes = {
      "gruvbox-custom" = ../dotfiles/opencode-theme.json;
    };
  };

  # home manager opencode doesn't support new cli.json yet, so we write it manually.
  # We still use home manager for theme management though...
  xdg.configFile."opencode/cli.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/v2/cli.json";
    theme.name = "gruvbox-custom";
    tabs.mode = "off";
  };

  programs.codex.enable = true;

  home.shellAliases = {
    opencode = "opencode2";
    oc = "opencode2";
  };
}

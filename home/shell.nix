{
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:

let
  yaziGruvboxDark = pkgs.fetchFromGitHub {
    owner = "bennyyip";
    repo = "gruvbox-dark.yazi";
    rev = "619fdc5844db0c04f6115a62cf218e707de2821e";
    hash = "sha256-Y/i+eS04T2+Sg/Z7/CGbuQHo5jxewXIgORTQm25uQb4=";
  };

  yaziGruvboxLightHard = pkgs.fetchFromGitHub {
    owner = "viddrobnic";
    repo = "gruvbox-light-hard.yazi";
    rev = "93b11906400a3af0b8abd506964e20108be10d6b";
    hash = "sha256-GzPV4naRB1kSM54vM9m0/jdxyUc0NUb1kcPgHlSWwIw=";
  };
in
{
  programs.nushell = {
    enable = true;
    package = pkgsUnstable.nushell;
    configFile.source = ../dotfiles/config.nu;
  };

  home.shell.enableNushellIntegration = true;

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      style = "compact";
      inline_height = 10;
      invert = true;
      show_help = false;
      show_preview = false;
      show_tabs = false;
      keymap_mode = "auto";
      enter_accept = true;
    };
    forceOverwriteSettings = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.yazi = {
    enable = true;
    package = pkgsUnstable.yazi;
    enableNushellIntegration = true;

    flavors = {
      "gruvbox-dark" = yaziGruvboxDark;
      "gruvbox-light-hard" = yaziGruvboxLightHard;
    };

    theme = {
      flavor.dark = "gruvbox-dark";
      flavor.light = "gruvbox-light-hard";
    };
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "[@](bold yellow dimmed)"
        "$hostname"
        " "
        "$directory"
        "$direnv"
        "$character"

      ];
      right_format = "$cmd_duration";

      add_newline = true;

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      username = {
        show_always = true;
        style_user = "bold yellow";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        style = "bold cyan";
        format = "[$hostname]($style)";
      };

      directory = {
        truncate_to_repo = true;
        home_symbol = "~";
        style = "bold white";
      };

      direnv = {
        disabled = false;

        # Show only loaded/unloaded (no allowed/denied text)
        format = "[$symbol$loaded](yellow)";
        symbol = "  ";

        loaded_msg = "";
        unloaded_msg = " ";
      };

      cmd_duration = {
        min_time = 0;
        format = "[\\[$duration\\]]($style)";
        style = "bold blue";
      };
    };
  };
}

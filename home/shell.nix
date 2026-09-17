{
  config,
  lib,
  ...
}:
{
  programs.nushell = {
    enable = true;
    configFile.source = ../dotfiles/config.nu;

    # Workaround for: https://github.com/nix-community/home-manager/issues/4313
    environmentVariables = config.home.sessionVariables;
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

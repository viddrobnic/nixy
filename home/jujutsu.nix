{
  lib,
  config,
  pkgs,
  pkgsUnstable,
  ...
}:

# NOTE: jujutsu doesn't have a built in nushell integration,
# which means that we have to generate and link completions
# manually.
let
  jjPkg = pkgsUnstable.jujutsu;

  jjNuCompletion =
    pkgs.runCommand "jj-nushell-completions"
      {
        nativeBuildInputs = [ jjPkg ];
      }
      ''
        mkdir -p $out
        jj util completion nushell > $out/completions-jj.nu
      '';

  nuCfgDirRel = lib.strings.removePrefix "${config.home.homeDirectory}/" config.programs.nushell.configDir;
in
{
  home.file."jj-nushell-completions" = {
    target = "${nuCfgDirRel}/completions-jj.nu";
    source = "${jjNuCompletion}/completions-jj.nu";
  };

  programs.nushell.extraConfig = ''
    use completions-jj.nu *
  '';

  programs.jujutsu = {
    enable = true;
    package = pkgsUnstable.jujutsu;
    settings = {
      user = {
        name = "Vid Drobnič";
        email = "me@viddrobnic.com";
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };

      ui = {
        default-command = "log";
        editor = "nvim";
        diff-editor = ":builtin";
        diff-formatter = [
          "difft"
          "--color=always"
          "$left"
          "$right"
        ];
      };

      aliases = {
        # Move the closest bookmark to the current commit. This is useful when
        # working on a named branch, creating a bunch of commits, and then needing
        # to update the bookmark before pushing.
        tug = [
          "bookmark"
          "move"
          "--from"
          "closest_bookmark(@-)"
          "--to"
          "@-"
        ];

        # Rebase the current branch onto the trunk.
        retrunk = [
          "rebase"
          "-d"
          "trunk()"
        ];

        pull = [
          "git"
          "fetch"
        ];
        push = [
          "git"
          "push"
        ];
      };

      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
      };

      template-aliases = {
        "format_timestamp(timestamp)" = "timestamp.ago()";
      };
    };
  };
}

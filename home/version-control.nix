{ pkgs, lib, ... }:
{
  home.packages = [ pkgs.git ];

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = lib.mkDefault "Vid Drobnič";
        email = lib.mkDefault "vid@drobnic.dev";
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = lib.mkDefault "~/.ssh/id_ed25519_git.pub";
      };

      ui = {
        default-command = "log";
        editor = "nvim";
        diff-editor = ":builtin";
        diff-formatter = [
          "difft"
          "--color=always"
          "--width"
          "$width"
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

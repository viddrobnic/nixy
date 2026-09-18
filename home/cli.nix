{ pkgs, ... }:
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
  # General-purpose tools that are useful outside software projects too.
  home.packages = with pkgs; [
    age
    difftastic
    ouch
    restic
    ripgrep
    sops
    ssh-to-age
    nixos-rebuild-ng
    typst
    typstyle
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "auto";
      theme-dark = "gruvbox-dark";
      theme-light = "gruvbox-light";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark_v2";
      vim_keys = true;
      update_ms = 1000;
    };
  };

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    shellWrapperName = "yy";

    flavors = {
      "gruvbox-dark" = yaziGruvboxDark;
      "gruvbox-light-hard" = yaziGruvboxLightHard;
    };

    theme = {
      flavor.dark = "gruvbox-dark";
      flavor.light = "gruvbox-light-hard";
    };
  };
}

{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;

  # I haven't gotten macos to play nicely with 'confirm' option yet. Until then,
  # just add keys to agent always.
  addKeysToAgentConfirm = if isDarwin then "yes" else "confirm";

  extraOptions = lib.mkIf isDarwin {
    "UseKeychain" = "yes";
  };
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = "~/.ssh/id_ed25519_git";
      identitiesOnly = true;
      addKeysToAgent = "yes";

      extraOptions = extraOptions;
    };

    personal = {
      hostname = "49.13.94.210";
      user = "root";
      port = 2222;
      identityFile = "~/.ssh/id_ed25519_server";
      identitiesOnly = true;
      addKeysToAgent = addKeysToAgentConfirm;

      extraOptions = extraOptions;
    };

    nixer = {
      hostname = "116.202.25.234";
      user = "vidd";
      port = 2222;
      identityFile = "~/.ssh/id_ed25519_server";
      identitiesOnly = true;
      addKeysToAgent = addKeysToAgentConfirm;

      extraOptions = extraOptions;
    };
  };
}

{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;

  # I haven't gotten macos to play nicely with 'confirm' option yet. Until then,
  # just add keys to agent always.
  addKeysToAgentConfirm = if isDarwin then "yes" else "confirm";

  useKeychain = lib.mkIf isDarwin "yes";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        IdentityFile = "~/.ssh/id_ed25519_git";
        IdentitiesOnly = true;
        AddKeysToAgent = "yes";
        UseKeychain = useKeychain;
      };

      personal = {
        HostName = "49.13.94.210";
        User = "root";
        Port = 2222;
        IdentityFile = "~/.ssh/id_ed25519_server";
        IdentitiesOnly = true;
        AddKeysToAgent = addKeysToAgentConfirm;
        UseKeychain = useKeychain;
      };

      nixer = {
        HostName = "116.202.25.234";
        User = "vidd";
        Port = 2222;
        IdentityFile = "~/.ssh/id_ed25519_server";
        IdentitiesOnly = true;
        AddKeysToAgent = addKeysToAgentConfirm;
        UseKeychain = useKeychain;
      };
    };
  };
}

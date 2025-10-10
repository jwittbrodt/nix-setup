{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.my.sshServer.enable = lib.mkEnableOption "ssh-server with authorized key login";

  config = lib.mkIf config.my.sshServer.enable {
    users.users.jonasw = {
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILzQMaqwP2kxyPglnN+B3/bzE+InGMOKdqZ5K1BI9/HR jonasw@JonasThinkpad-2021-09-23"
      ];
    };
    services = {
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
        openFirewall = true;
      };
    };
    security.sudo.wheelNeedsPassword = false;
  };
}

{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "Host *" = {
        addKeysToAgent = "yes";
      };
    };
  };
  services.ssh-agent = {
    enable = true;
    defaultMaximumIdentityLifetime = 57600;
  };
}

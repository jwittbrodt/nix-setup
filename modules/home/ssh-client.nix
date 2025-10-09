{ pkgs, config, ... }:

{
  programs.ssh = {
    enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        addKeysToAgent = "yes";
      };
  };
  services.ssh-agent = {
    enable = true;
    defaultMaximumIdentityLifetime = 57600;
  };
}

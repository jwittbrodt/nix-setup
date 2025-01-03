{ config, lib, pkgs, ... }:

{
  options.my.dnsServer.enable = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.my.dnsServer.enable {
    services.blocky.enable = true;
  };
}

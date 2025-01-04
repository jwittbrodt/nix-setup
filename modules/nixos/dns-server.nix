{ config, lib, pkgs, ... }:

{
  options.my.dnsServer.enable = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.my.dnsServer.enable {
    services.blocky = {
      enable = true;
      settings = {
        upstreams.groups.default = [
          "tcp-tls:dns3.digitalcourage.de:853"
          "tcp-tls:ns.digitale-gesellschaft.ch:853"
          "tcp-tls:jabber-germany.de:853"
          "tcp-tls:ns1.opennameserver.org:853"
          "tcp-tls:ns2.opennameserver.org:853"
          "tcp-tls:ns3.opennameserver.org:853"
        ];
        bootstrapDns = {
          upstream = "tcp-tls:dns3.digitalcourage.de:853";
          ips = [ "5.9.164.112" ];
        };
        conditional = {
          mapping = {
            "fritz.box" = "192.168.178.1";
            "." = "168.168.178.1";
          };
        };
        log.level = "warn";
        caching = {
          prefetching = true;
        };
        blocking = {
          denylists = {
            ads = [
              https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.txt
            ];
            threats = [
              https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/tif.txt
            ];
          };
          clientGroupsBlock.default = [ "ads" "threats" ];
        };
      };
    };
    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.my.dnsServer.enable = lib.mkEnableOption "dns server with filtering";

  config = lib.mkIf config.my.dnsServer.enable {
    services.blocky = {
      enable = true;
      settings = {
        upstreams.groups.default = [
          "tcp-tls:dns3.digitalcourage.de:853"
          "tcp-tls:dns.digitale-gesellschaft.ch:853"
          "tcp-tls:jabber-germany.de:853"
          "tcp-tls:ns1.opennameserver.org:853"
          "tcp-tls:ns2.opennameserver.org:853"
          "tcp-tls:ns3.opennameserver.org:853"
        ];
        bootstrapDns = {
          upstream = "8.8.8.8";
        };
        conditional = {
          mapping = {
            "fritz.box" = "192.168.178.1";
            "home.lab" = "192.168.178.250";
          };
        };
        log.level = "warn";
        caching = {
          prefetching = true;
        };
        blocking = {
          denylists = {
            ads = [
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/ultimate.txt"
            ];
            threats = [
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/tif.txt"
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/dyndns.txt"
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/hoster.txt"
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/spam-tlds-onlydomains.txt"
            ];
            undesirable = [
              "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/gambling.txt"
            ];
          };
          clientGroupsBlock.default = [
            "ads"
            "threats"
            "undesirable"
          ];
        };
      };
    };
    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };
}

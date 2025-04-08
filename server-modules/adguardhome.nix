{ config, ... }:
let domain = "adguard.dilou.me";
in {
  services = {
    adguardhome = {
      enable = true;
      port = 3000;
    };

    nginx.virtualHosts."${domain}" = {
      useACMEHost = "dilou.me";
      forceSSL = true;
      default = false;
      locations."/" = {
        proxyPass =
          "http://127.0.0.1:${toString config.services.adguardhome.port}";
      };
    };
  };
}

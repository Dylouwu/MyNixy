{ config, ... }:
let domain = "adguard.${config.var.domain}";
in {
  services.adguardhome = {
    enable = true;
    port = 3000;
  };

  services.nginx.virtualHosts."${domain}" = {
    useACMEHost = config.var.domain;
    forceSSL = true;
    locations."/" = {
      proxyPass =
        "http://127.0.0.1:${toString config.services.adguardhome.port}";
    };
  };
}

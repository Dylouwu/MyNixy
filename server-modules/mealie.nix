{ config, ... }:
let domain = "mealie.${config.var.domain}";
in {
  services = {
    mealie = {
      enable = true;
      port = 8092;
    };

    nginx.virtualHosts."${domain}" = {
      useACMEHost = config.var.domain;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.mealie.port}";
      };
    };
  };
}

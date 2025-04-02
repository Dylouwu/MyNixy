{ config, ... }:
let domain = "mealie.dilou.me";
in {
  services = {
    mealie = {
      enable = true;
      port = 8092;
    };

    nginx.virtualHosts."${domain}" = {
      useACMEHost = "dilou.me";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.mealie.port}";
      };
    };
  };
}

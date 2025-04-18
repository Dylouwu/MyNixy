{ config, ... }:
let domain = "mealisearch.dilou.me";
in {
  services = {
    meilisearch = {
      enable = true;
      listenPort = 7700;
    };

    nginx.virtualHosts."${domain}" = {
      useACMEHost = "dilou.me";
      forceSSL = true;
      locations."/" = {
        proxyPass =
          "http://127.0.0.1:${toString config.services.meilisearch.listenPort}";
      };
    };
  };
}

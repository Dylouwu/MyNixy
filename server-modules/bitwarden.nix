{ config, ... }:
let domain = "vault.dilou.me";
in {
  services = {
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://" + domain;
        SIGNUPS_ALLOWED = true;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";
      };
    };

    nginx.virtualHosts."${domain}" = {
      useACMEHost = "dilou.me";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${
            toString config.services.vaultwarden.config.ROCKET_PORT
          }";
      };
    };
  };
}

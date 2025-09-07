{ config, ... }:
let domain = "atuin.${config.var.domain}";
in {
  services.atuin = {
    enable = true;
    port = 8888;
    openFirewall = false;
    openRegistration = true;
    maxHistoryLength = 32768;
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

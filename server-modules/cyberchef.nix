{ pkgs, config, ... }: {
  services.nginx.virtualHosts."cyber.${config.var.domain}" = {
    useACMEHost = config.var.domain;
    forceSSL = true;
    root = pkgs.cyberchef + "/share/cyberchef";
  };
}

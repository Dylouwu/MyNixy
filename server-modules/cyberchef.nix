{ pkgs, ... }: {
  services.nginx.virtualHosts."cyber.dilou.me" = {
    addSSL = true;
    enableACME = true;
    root = pkgs.cyberchef;
  };
}

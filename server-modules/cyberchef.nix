{ pkgs, ... }: {
  services.nginx.virtualHosts."cyber.dilou.me" = {
    useACMEHost = "dilou.me";
    forceSSL = true;
    root = pkgs.cyberchef + "/share/cyberchef";
  };
}

{ pkgs, config, ... }:
let
  cyberchefPort = 8000; # Internal port for the Python HTTP server
  domain = "cyber.dilou.me";
in {
  # Install CyberChef
  environment.systemPackages = with pkgs; [ cyberchef ];

  # Run CyberChef as a service using a simple HTTP server
  systemd.services.cyberchef = {
    enable = true;
    description = "CyberChef - The Cyber Swiss Army Knife";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.python3}/bin/python -m http.server ${
          toString cyberchefPort
        } --directory ${pkgs.cyberchef}/share/cyberchef";
      Restart = "always";
      User = "cyberchef";
      Group = "cyberchef";
      WorkingDirectory = "/var/lib/cyberchef";
    };
  };

  # Create system user and group for the service
  users.users.cyberchef = {
    isSystemUser = true;
    group = "cyberchef";
    home = "/var/lib/cyberchef";
  };
  users.groups.cyberchef = { };

  # Set up nginx as a reverse proxy to the CyberChef service
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    useACMEHost = "dilou.me"; # Use your existing wildcard certificate

    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString cyberchefPort}";
      proxyWebsockets = true; # In case CyberChef uses WebSockets
      extraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
      '';
    };
  };

  # Ensure the CyberChef directory exists
  systemd.tmpfiles.rules =
    [ "d /var/lib/cyberchef 0755 cyberchef cyberchef -" ];
}

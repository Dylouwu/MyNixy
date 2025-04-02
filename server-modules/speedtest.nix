{ config, pkgs, ... }:

let domain = "speed.dilou.me";
in {
  # Create directory for LibreSpeed
  systemd.tmpfiles.rules = [ "d /var/lib/librespeed 0755 nginx nginx -" ];

  # Download and set up LibreSpeed
  systemd.services.librespeed-setup = {
    description = "Set up LibreSpeed";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "setup-librespeed" ''
                # Download latest LibreSpeed if not already present
                if [ ! -f /var/lib/librespeed/index.html ]; then
                  ${pkgs.curl}/bin/curl -L https://github.com/librespeed/speedtest/archive/refs/tags/1.2.0.tar.gz | ${pkgs.gnutar}/bin/tar -xz -C /tmp
                  ${pkgs.coreutils}/bin/cp -r /tmp/speedtest-1.2.0/* /var/lib/librespeed/
                  ${pkgs.coreutils}/bin/chown -R nginx:nginx /var/lib/librespeed
                fi
                
                # Create a basic configuration
                cat > /var/lib/librespeed/speedtest_config.js <<EOL
        const SPEEDTEST_SERVERS=[
          {
            "name": "${domain}",
            "server": "./",
            "dlURL": "garbage.php",
            "ulURL": "empty.php",
            "pingURL": "empty.php",
            "getIpURL": "getIP.php"
          }
        ];
        const SPEEDTEST_TELEMETRY_LEVEL = 0;
        EOL
                ${pkgs.coreutils}/bin/chown nginx:nginx /var/lib/librespeed/speedtest_config.js
      '';
    };
  };

  # Add the virtual host for LibreSpeed to your existing nginx config
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    useACMEHost = "dilou.me"; # Use your wildcard certificate

    root = "/var/lib/librespeed";

    locations = {
      "/" = { index = "index.html"; };

      "~ \\.php$" = {
        extraConfig = ''
          fastcgi_pass  unix:${config.services.phpfpm.pools.librespeed.socket};
          fastcgi_index index.php;
          include ${pkgs.nginx}/conf/fastcgi_params;
          include ${pkgs.nginx}/conf/fastcgi.conf;
        '';
      };
    };
  };

  # PHP configuration for LibreSpeed
  services.phpfpm.pools.librespeed = {
    user = "nginx";
    settings = {
      "listen.owner" = config.services.nginx.user;
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 4;
      "pm.max_requests" = 500;
    };
  };

  # Enable PHP
  services.phpfpm.pools.librespeed.phpPackage =
    pkgs.php.withExtensions ({ enabled, all }: enabled ++ [ all.opcache ]);
}

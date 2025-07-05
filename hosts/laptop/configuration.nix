{ config, inputs, pkgs, ... }: {
  imports = [
    # Mostly system related configuration
    ../../nixos/audio.nix
    ../../nixos/docker.nix
    ../../nixos/fonts.nix
    ../../nixos/grub.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/nvidia.nix # CHANGEME : remove this line if you don't have an Nvidia GPU
    ../../nixos/sddm.nix
    ../../nixos/steam.nix
    ../../nixos/tailscale.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/xserver.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  stylix.targets.grub.enable = false;
  services.nginx = {
    enable = true;
    virtualHosts."socme-frontend.local" = {
      root = "${
          inputs.socme.packages.${pkgs.system}.socme-frontend
        }/share/socme-frontend";

      locations."/api/" = {
        proxyPass =
          "http://127.0.0.1:${toString config.services.socme-backend.port}/";
        recommendedProxySettings = true;
        extraConfig = ''
          rewrite ^/api/(.*) /$1 break;

          # CORS headers for API endpoint
          add_header 'Access-Control-Allow-Origin' '*' always;
          add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, PATCH, OPTIONS' always; # Added PUT, DELETE for completeness
          add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type' always;
          add_header 'Access-Control-Allow-Credentials' 'true' always; # Often needed for cookies/auth

          # Handle preflight requests for API
          if ($request_method = 'OPTIONS') {
            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, PATCH, OPTIONS';
            add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type';
            add_header 'Access-Control-Max-Age' 1728000;
            add_header 'Content-Type' 'text/plain charset=UTF-8';
            add_header 'Content-Length' 0;
            return 204;
          }
        '';
      };

      locations."/" = {
        extraConfig = ''
          try_files $uri $uri/ /index.html =404; # Fallback vers index.html pour les routes SPA
        '';
      };

    };
  };

  networking.extraHosts = ''
    127.0.0.1 socme-frontend.local
  '';
  services.socme-backend.enable = true;

  wazuh = {
    enable = true;
    autostart = true;
    version = "v4.12.0"; # Or any other version
    webui.dashboard.port = 5601; # Can be overridden if needed
    # ... other options you want to override
  };

  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}

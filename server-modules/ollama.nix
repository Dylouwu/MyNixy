{ pkgs, config, ... }:
let
  domain = "ai.${config.var.domain}";
in
{
  services = {
    open-webui = {
      enable = true;
      port = 8093;
    };

    ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = [ "gemma4:e4b" ];
    };

    nginx.virtualHosts = {
      "${domain}" = {
        useACMEHost = config.var.domain;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.open-webui.port}";

          extraConfig = ''
            proxy_http_version 1.1;
            proxy_buffering off;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_cache off;
          '';
        };
      };
    };
  };
}

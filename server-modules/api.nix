{ config, ... }:
let domain = "api.${config.var.domain}";
in {
  services.nginx.virtualHosts."${domain}" = {
    useACMEHost = config.var.domain;
    forceSSL = true;
    locations."/mc" = {
      proxyPass = "http://localhost:5000";
      recommendedProxySettings = true;

      extraConfig = ''
        # CORS headers
        add_header 'Access-Control-Allow-Origin' '*' always;
        add_header 'Access-Control-Allow-Methods' 'POST, OPTIONS' always;
        add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type' always;

        # Handle preflight requests
        if ($request_method = 'OPTIONS') {
          add_header 'Access-Control-Allow-Origin' '*';
          add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
          add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type';
          add_header 'Access-Control-Max-Age' 1728000;
          add_header 'Content-Type' 'text/plain charset=UTF-8';
          add_header 'Content-Length' 0;
          return 204;
        }
      '';
    };
  };
}

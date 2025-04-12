{ config, ... }:
let domain = "dilou.me";
in {
  services.nginx = {
    enable = true;

    virtualHosts."default" = {
      default = true;
      locations."/" = { return = 444; };
    };

    virtualHosts."*.${domain}" = {
      useACMEHost = domain;
      forceSSL = true;
      locations."/" = { return = 444; };
    };
    virtualHosts."api.${domain}" = {
      useACMEHost = "api.${domain}";
      forceSSL = true;
      locations."/mc" = {
        proxyPass =
          "http://localhost:5000"; # Forward requests to backend on port 5000
        proxySetHeader = {
          "X-Real-IP" = "$remote_addr";
          "X-Forwarded-For" = "$proxy_add_x_forwarded_for";
          "X-Forwarded-Proto" = "$scheme";
          "Host" = "$host";
        };
        addHeader = {
          "Access-Control-Allow-Origin" = "*";
          "Access-Control-Allow-Methods" = "GET, POST, OPTIONS";
          "Access-Control-Allow-Headers" = "Authorization, Content-Type";
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = config.var.git.email;
  };

  security.acme.certs."${domain}" = {
    domain = domain;
    extraDomainNames = [ "*.${domain}" ];
    group = "nginx";
    dnsProvider = "cloudflare";
    dnsPropagationCheck = true;
    credentialsFile = config.sops.secrets.cloudflare-dns-token.path;
  };
}

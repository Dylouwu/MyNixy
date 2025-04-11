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

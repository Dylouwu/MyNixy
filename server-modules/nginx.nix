{ config, ... }: {
  services.nginx = {
    enable = true;

    virtualHosts."default" = {
      default = true;
      locations."/" = { return = 444; };
    };

    virtualHosts."*.${config.var.domain}" = {
      useACMEHost = config.var.domain;
      forceSSL = true;
      locations."/" = { return = 444; };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = config.var.git.email;
  };

  security.acme.certs."${config.var.domain}" = {
    domain = config.var.domain;
    extraDomainNames = [ "*.${config.var.domain}" ];
    group = "nginx";
    dnsProvider = "cloudflare";
    dnsPropagationCheck = true;
    credentialsFile = config.sops.secrets.cloudflare-dns-token.path;
  };
}

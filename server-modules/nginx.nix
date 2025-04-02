{ config, ... }: {
  services.nginx = { enable = true; };

  security.acme = {
    acceptTerms = true;
    defaults.email = config.var.git.email;
  };

  security.acme.certs."dilou.me" = {
    domain = "dilou.me";
    extraDomainNames = [ "*.dilou.me" ];
    group = "nginx";

    dnsProvider = "cloudflare";
    dnsPropagationCheck = true;
    credentialsFile = config.sops.secrets.cloudflare-dns-token.path;
  };

  services.nginx.virtualHosts."default" = {
    default = true;
    locations."/" = { return = 444; };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
}

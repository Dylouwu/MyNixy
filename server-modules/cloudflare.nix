{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.sops.secrets.cloudflare-dns-token-without-header.path;

    domains = [ "mc.${config.var.domain}" ];
  };
}

{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.sops.secrets.cloudflare-dns-token.path;

    domains = [ "mc.dilou.me" ];
  };
}

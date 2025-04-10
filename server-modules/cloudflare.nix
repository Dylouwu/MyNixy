{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.sops.secrets.cloudflare-dns-token.path;

    records = [ "mc.dilou.me" ];
  };
}

{ pkgs, config, ... }:
let domain = "cloud.dilou.me";
in {
  services = {
    nginx.virtualHosts = {
      "${domain}" = {
        # DNS-01 challenge
        useACMEHost = "dilou.me";
        forceSSL = true;
      };
    };
    nextcloud = {
      enable = true;
      hostName = domain;
      package = pkgs.nextcloud31;
      database.createLocally = true;
      configureRedis = true;
      maxUploadSize = "64G";
      https = true;
      autoUpdateApps.enable = true;
      settings = {
        trusted_domains = [ domain ];
        default_phone_region = "FR";
        overwriteprotocol = "https";
      };

      config = {
        dbtype = "pgsql";
        adminuser = config.var.username;
        adminpassFile = config.sops.secrets.nextcloud-pwd.path;
      };
      # Suggested by Nextcloud's health check.
      phpOptions."opcache.interned_strings_buffer" = "16";
    };

  };
}

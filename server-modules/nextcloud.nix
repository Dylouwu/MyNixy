{ pkgs, config, ... }:
let domain = "cloud.${config.var.domain}";
in {
  services = {
    nginx.virtualHosts = {
      "${domain}" = {
        # DNS-01 challenge
        useACMEHost = config.var.domain;
        forceSSL = true;
      };
    };
    nextcloud = {
      enable = true;
      hostName = domain;
      package = pkgs.nextcloud32;
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

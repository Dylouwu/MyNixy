{ config, lib, ... }:
let
  domain = "home.dilou.me";

  rgb-to-hsl = color:
    let
      r = ((lib.toInt config.lib.stylix.colors."${color}-rgb-r") * 100.0) / 255;
      g = ((lib.toInt config.lib.stylix.colors."${color}-rgb-g") * 100.0) / 255;
      b = ((lib.toInt config.lib.stylix.colors."${color}-rgb-b") * 100.0) / 255;
      max = lib.max r (lib.max g b);
      min = lib.min r (lib.min g b);
      delta = max - min;
      fmod = base: int: base - (int * builtins.floor (base / int));
      h = if delta == 0 then
        0
      else if max == r then
        60 * (fmod ((g - b) / delta) 6)
      else if max == g then
        60 * (((b - r) / delta) + 2)
      else if max == b then
        60 * (((r - g) / delta) + 4)
      else
        0;
      l = (max + min) / 2;
      s = if delta == 0 then
        0
      else
        100 * delta / (100 - lib.max (2 * l - 100) (100 - (2 * l)));
      roundToString = value: toString (builtins.floor (value + 0.5));
    in lib.concatMapStringsSep " " roundToString [ h s l ];
in {
  services = {
    glance = {
      enable = true;
      settings = {
        theme = {
          background-color = rgb-to-hsl "base00";
          primary-color = rgb-to-hsl "base0D";
          positive-color = rgb-to-hsl "base0C";
          contrast-multiplier = 1.4;
        };
        pages = [{
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                }
                {
                  type = "weather";
                  location = "Paris, France";
                }
                {
                  type = "markets";
                  markets = [
                    {
                      symbol = "SPY";
                      name = "S&P 500";
                    }
                    {
                      symbol = "^FCHI";
                      name = "CAC 40";
                    }
                    {
                      symbol = "EURUSD=X";
                      name = "EUR/USD";
                    }
                  ];
                }
                {
                  type = "dns-stats";
                  service = "adguard";
                  url = "https://adguard.dilou.me";
                  username = "dilounix";
                  password = "\${secret:adguard-pwd}";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  search-engine = "google";
                }
                {
                  type = "server-stats";
                  servers = [{
                    type = "local";
                    name = "Hyrule";
                  }];
                }
                {
                  type = "monitor";
                  title = "Services";
                  cache = "1m";
                  sites = [
                    {
                      title = "Vaultwarden";
                      url = "https://vault.dilou.me";
                      icon = "si:bitwarden";
                    }
                    {
                      title = "Nextcloud";
                      url = "https://cloud.dilou.me";
                      icon = "si:nextcloud";
                    }
                    {
                      title = "Adguard";
                      url = "https://adguard.dilou.me";
                      icon = "si:adguard";
                    }
                    # {
                    #   title = "Hoarder";
                    #   url = "https://hoarder.dilou.me";
                    #   icon = "si:bookstack";
                    # }
                    {
                      title = "Mealie";
                      url = "https://mealie.dilou.me";
                      icon = "si:mealie";
                    }
                    {
                      title = "CyberChef";
                      url = "https://cyber.dilou.me";
                      icon = "si:codechef";
                    }
                  ];
                }
                # {
                #   type = "monitor";
                #   title = "*arr";
                #   cache = "1m";
                #   sites = [
                #     {
                #       title = "Jellyfin";
                #       url = "https://jellyfin.dilou.me";
                #       icon = "si:jellyfin";
                #     }
                #     {
                #       title = "Jellyseerr";
                #       url = "https://jellyseerr.dilou.me";
                #       icon = "si:odysee";
                #     }
                #     {
                #       title = "Radarr";
                #       url = "https://radarr.dilou.me";
                #       icon = "si:radarr";
                #     }
                #     {
                #       title = "Sonarr";
                #       url = "https://sonarr.dilou.me";
                #       icon = "si:sonarr";
                #     }
                #     {
                #       title = "Prowlarr";
                #       url = "https://prowlarr.dilou.me";
                #       icon = "si:podcastindex";
                #     }
                #     {
                #       title = "SABnzbd";
                #       url = "https://sabnzbd.dilou.me";
                #       icon = "si:sabanci";
                #     }
                #     {
                #       title = "Transmission";
                #       url = "https://transmission.dilou.me";
                #       icon = "si:transmission";
                #     }
                #   ];
                # }
                {
                  type = "repository";
                  repository = "Dylouwu/MyNixy";
                  pull-requests-limit = 5;
                  issues-limit = 3;
                }
                {
                  type = "repository";
                  repository = "anotherhadi/awesome-wallpapers";
                  pull-requests-limit = 5;
                  issues-limit = 3;
                }
                { type = "hacker-news"; }
              ];
            }
          ];
          name = "Home";
        }];
        server = { port = 5678; };
      };
    };
    nginx.virtualHosts."${domain}" = {
      useACMEHost = "dilou.me";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${
            toString config.services.glance.settings.server.port
          }";
      };
    };

  };
}

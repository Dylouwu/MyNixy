{ config, lib, ... }:
let
  domain = config.var.domain;

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
        theme = lib.mkForce {
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
                  timezones = [
                    {
                      timezone = "Asia/Tokyo";
                      label = "Tokyo/Seoul";
                    }
                    {
                      timezone = "Europe/Dublin";
                      label = "Dublin";
                    }
                    {
                      timezone = "America/New_York";
                      label = "New York";
                    }
                  ];
                }
                {
                  type = "weather";
                  location = "Paris, France";
                }
                {
                  type = "twitch-channels";
                  channels =
                    [ "guep" "kamet0" "caliste_lol" "thebausffs" "otplol_" ];
                }
                {
                  type = "markets";
                  markets = [
                    {
                      symbol = "ETH-USD";
                      name = "Ethereum";
                      chart-link =
                        "https://www.tradingview.com/chart/?symbol=INDEX:ETHUSD";
                    }
                    {
                      symbol = "EURJPY=X";
                      name = "EUR/JPY";
                    }
                    {
                      symbol = "EURUSD=X";
                      name = "EUR/USD";
                    }
                    {
                      symbol = "SPY";
                      name = "S&P 500";
                    }
                    {
                      symbol = "^FCHI";
                      name = "CAC 40";
                    }
                  ];
                }
                {
                  type = "custom-api";
                  title = "Steam sales";
                  cache = "6h";
                  url =
                    "https://store.steampowered.com/api/featuredcategories?cc=jp";
                  template = ''
                                    <ul class="list list-gap-10 collapsible-container" data-collapse-after="5">
                    {{ range .JSON.Array "specials.items" }}
                      <li>
                        <a class="size-h4 color-highlight block text-truncate" href="https://store.steampowered.com/app/{{ .Int "id" }}/">{{ .String "name" }}</a>
                        <ul class="list-horizontal-text">
                          <li>{{ .Int "final_price" | toFloat | mul 0.01 | printf "¥%.0f" }}</li>
                          {{ $discount := .Int "discount_percent" }}
                          <li{{ if ge $discount 40 }} class="color-positive"{{ end }}>{{ $discount }}% off</li>
                        </ul>
                      </li>
                    {{ end }}
                    </ul>
                  '';

                }
                {
                  type = "dns-stats";
                  service = "adguard";
                  url = "https://adguard.${domain}";
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
                    hide-swap = true;
                    hide-mountpoints-by-default = true;
                    mountpoints."/".hide = false;
                  }];
                }
                {
                  type = "monitor";
                  title = "Services";
                  cache = "1m";
                  sites = [
                    {
                      title = "Vaultwarden";
                      url = "https://vault.${domain}";
                      icon = "si:bitwarden";
                    }
                    {
                      title = "Nextcloud";
                      url = "https://cloud.${domain}";
                      icon = "si:nextcloud";
                    }
                    {
                      title = "Adguard";
                      url = "https://adguard.${domain}";
                      icon = "si:adguard";
                    }
                    {
                      title = "Mealie";
                      url = "https://mealie.${domain}";
                      icon = "si:mealie";
                    }
                    {
                      title = "CyberChef";
                      url = "https://cyber.${domain}";
                      icon = "si:codechef";
                    }
                  ];
                }

                {
                  type = "custom-api";
                  title = "Paradisum";
                  url = "https://api.mcstatus.io/v2/status/java/mc.${domain}";
                  cache = "30s";
                  template = ''
                    <div style="display: flex; align-items: center; gap: 12px;">
                      <div style="width: 40px; height: 40px; flex-shrink: 0; border-radius: 4px;
                                  display: flex; justify-content: center; align-items: center; overflow: hidden;">
                        {{ if .JSON.Bool "online" }}
                          <img src="{{ .JSON.String "icon" | safeURL }}" width="64" height="64" style="object-fit: contain;">
                        {{ else }}
                          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" style="width:32px; height:32px; opacity:0.5;">
                            <path fill-rule="evenodd" d="M1 5.25A2.25 2.25 0 0 1 3.25 3h13.5A2.25 2.25 0 0 1 19 5.25v9.5A2.25 2.25 0 0 1 16.75 17H3.25A2.25 2.25 0 0 1 1 14.75v-9.5Zm1.5 5.81v3.69c0 .414.336.75.75.75h13.5a.75.75 0 0 0 .75-.75v-2.69l-2.22-2.219a.75.75 0 0 0-1.06 0l-1.91 1.909.47.47a.75.75 0 1 1-1.06 1.06L6.53 8.091a.75.75 0 0 0-1.06 0l-2.97 2.97ZM12 7a1 1 0 1 1-2 0 1 1 0 0 1 2 0Z" clip-rule="evenodd" />
                          </svg>
                        {{ end }}
                      </div>
                      <div style="flex-grow: 1; min-width: 0; display: flex; flex-direction: column; justify-content: center;">
                        <a class="size-h4 block text-truncate color-highlight">
                          {{ .JSON.String "host" }}
                          {{ if .JSON.Bool "online" }}
                            <span style="width: 8px; height: 8px; border-radius: 50%;
                                        background-color: var(--color-positive); display: inline-block;
                                        vertical-align: middle;" data-popover-type="text" data-popover-text="Online">
                            </span>
                          {{ else }}
                            <span style="width: 8px; height: 8px; border-radius: 50%;
                                        background-color: var(--color-negative); display: inline-block;
                                        vertical-align: middle;" data-popover-type="text" data-popover-text="Offline">
                            </span>
                          {{ end }}
                        </a>
                        <ul class="list-horizontal-text">
                          <li>
                            {{ if .JSON.Bool "online" }}
                              <span>{{ .JSON.String "version.name_clean" }}</span>
                            {{ else }}
                              <span>Offline</span>
                            {{ end }}
                          </li>
                          {{ if .JSON.Bool "online" }}
                            <li>
                              <p style="display: inline-flex; align-items: center;">
                                <!-- Player count and icon etc. -->
                                {{ .JSON.Int "players.online" | formatNumber }}/{{ .JSON.Int "players.max" | formatNumber }} players
                              </p>
                            </li>
                          {{ end }}
                        </ul>
                      </div>

                      <!-- Control button (moved to the right and color changes) -->
                      <div>
                        {{ if .JSON.Bool "online" }}
                          <button id="server-control" onclick="fetch('https://api.${domain}/mc/server/stop', { 
                                                                  method: 'POST', 
                                                                  headers: { 
                                                                    'Content-Type': 'application/json', 
                                                                    'Authorization': 'Bearer ''${secret:glance-api-key}'
                                                                  }
                                                                }).then(() => { 
                                                                  location.reload(); 
                                                                });" 
                                  style="padding: 8px 16px; background-color: red; color: white; border: none; border-radius: 4px;"
                                  id="stop-button">
                            Stop Server
                          </button>
                        {{ else }}
                          <button id="server-control" onclick="fetch('https://api.${domain}/mc/server/start', { 
                                                                  method: 'POST', 
                                                                  headers: { 
                                                                    'Content-Type': 'application/json',
                                                                    'Authorization': 'Bearer ''${secret:glance-api-key}'
                                                                  }
                                                                }).then(() => { 
                                                                  location.reload();
                                                                });" 
                                  style="padding: 8px 16px; background-color: green; color: white; border: none; border-radius: 4px;"
                                  id="start-button">
                            Start Server
                          </button>
                        {{ end }}
                      </div>
                    </div> 
                    <style>
                      /* Button dimming effect on hover */
                      button {
                        transition: opacity 0.3s ease;
                      }

                      button:hover {
                        opacity: 0.7;
                      }

                    </style>
                  '';
                }
                {
                  type = "custom-api";
                  title = "My devices";
                  title-url = "https://login.tailscale.com/admin/machines";
                  url =
                    "https://api.tailscale.com/api/v2/tailnet/dylouwu.github/devices";
                  headers.Authorization = "Bearer \${secret:tailscale-api-key}";
                  cache = "5m";
                  template = ''
                    {{ $enableOnlineIndicator := true }}

                    <style>
                      .device-info-container {
                        position: relative;
                        overflow: hidden;
                        height: 1.5em;
                      }

                      .device-info {
                        display: flex;
                        transition: transform 0.2s ease, opacity 0.2s ease;
                      }

                      .device-ip {
                        position: absolute;
                        top: 0;
                        left: 0;
                        transform: translateY(-100%);
                        opacity: 0;
                        transition: transform 0.2s ease, opacity 0.2s ease;
                      }

                      .device-info-container:hover .device-info {
                        transform: translateY(100%);
                        opacity: 0;
                      }

                      .device-info-container:hover .device-ip {
                        transform: translateY(0);
                        opacity: 1;
                      }

                      .update-indicator {
                        width: 8px;
                        height: 8px;
                        border-radius: 50%;
                        background-color: var(--color-primary);
                        display: inline-block;
                        margin-left: 4px;
                        vertical-align: middle;
                      }

                      .offline-indicator {
                        width: 8px;
                        height: 8px;
                        border-radius: 50%;
                        background-color: var(--color-negative);
                        display: inline-block;
                        margin-left: 4px;
                        vertical-align: middle;
                      }

                      .online-indicator {
                        width: 8px;
                        height: 8px;
                        border-radius: 50%;
                        background-color: var(--color-positive);
                        display: inline-block;
                        margin-left: 4px;
                        vertical-align: middle;
                      }

                      .device-name-container {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                      }

                      .indicators-container {
                        display: flex;
                        align-items: center;
                        gap: 4px;
                      }
                    </style>
                    <ul class="list list-gap-10 collapsible-container" data-collapse-after="4">
                      {{ range .JSON.Array "devices" }}
                      <li>
                        <div class="flex items-center gap-10">
                          <div class="device-name-container grow">
                            <span class="size-h4 block text-truncate color-primary">
                              {{ findMatch "^([^.]+)" (.String "name") }}
                            </span>
                            <div class="indicators-container">
                              {{ if (.Bool "updateAvailable") }}
                              <span class="update-indicator" data-popover-type="text" data-popover-text="Update Available"></span>
                              {{ end }}

                              {{ $lastSeen := .String "lastSeen" | parseTime "rfc3339" }}
                              {{ if not ($lastSeen.After (offsetNow "-10s")) }}
                              {{ $lastSeenTimezoned := $lastSeen.In now.Location }}
                              <span class="offline-indicator" data-popover-type="text"
                                data-popover-text="Offline - Last seen {{ $lastSeenTimezoned.Format " Jan 2 3:04pm" }}"></span>
                              {{ else if $enableOnlineIndicator }}
                                <span class="online-indicator" data-popover-type="text" data-popover-text="Online"></span>
                              {{ end }}
                            </div>
                          </div>
                        </div>
                        <div class="device-info-container">
                          <ul class="list-horizontal-text device-info">
                            <li>{{ .String "os" }}</li>
                            <li>{{ .String "user" }}</li>
                          </ul>
                          <div class="device-ip">
                            {{ .String "addresses.0"}}
                          </div>
                        </div>
                      </li>
                      {{ end }}
                    </ul>                  
                  '';
                }
                {
                  type = "group";
                  widgets = let
                    sharedProperties = {
                      type = "reddit";
                      collapse-after = 6;
                      limit = 12;
                    };
                  in [
                    (sharedProperties // { subreddit = "cybersecurity"; })
                    (sharedProperties // { subreddit = "nixos"; })
                    (sharedProperties // { subreddit = "linux"; })
                    (sharedProperties // { subreddit = "cpp"; })
                    (sharedProperties // { subreddit = "games"; })
                    (sharedProperties // { subreddit = "programming"; })
                  ];
                }

                {
                  type = "hacker-news";
                  collapse-after = 6;
                  limit = 12;
                }
              ];
            }
          ];
          name = "Home";
          hide-desktop-navigation = true;
        }];
        server = { port = 5678; };
      };
    };

    nginx.virtualHosts."home.${domain}" = {
      useACMEHost = "${domain}";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${
            toString config.services.glance.settings.server.port
          }";
      };
    };
  };

  users = {
    groups.glance = { };
    users.glance = {
      isSystemUser = true;
      description = "Glance user";
      group = "glance";
    };
  };

  systemd.services.glance = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "glance";
      Group = "glance";
    };
  };
}

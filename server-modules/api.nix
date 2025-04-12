let domain = "api.dilou.me";
in {
  virtualHosts."${domain}" = {
    useACMEHost = "${domain}";
    forceSSL = true;
    locations."/mc" = {
      proxyPass =
        "http://localhost:5000"; # Forward requests to backend on port 5000
      proxySetHeader = {
        "X-Real-IP" = "$remote_addr";
        "X-Forwarded-For" = "$proxy_add_x_forwarded_for";
        "X-Forwarded-Proto" = "$scheme";
        "Host" = "$host";
      };
      addHeader = {
        "Access-Control-Allow-Origin" = "*";
        "Access-Control-Allow-Methods" = "GET, POST, OPTIONS";
        "Access-Control-Allow-Headers" = "Authorization, Content-Type";
      };
    };
  };
}

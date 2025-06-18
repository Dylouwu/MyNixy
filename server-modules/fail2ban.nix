{
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "10.0.0.0/8"
      "172.16.0.0/12"
      "192.168.0.0/16"
      "8.8.8.8" # whitelist a specific IP
      "100.104.157.94"
      "100.104.210.42"
      "100.116.106.93"
    ];
    bantime = "24h";
    bantime-increment = {
      enable = true;
      formula =
        "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      maxtime = "168h";
      overalljails = true;
    };
  };
}

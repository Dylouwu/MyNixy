{
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
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

{ config, ... }: {
  services.glance-minecraft-power = {
    enable = true;
    minecraftServerName = "paradisum";
    host = "mc.dilou.me";
    apiKeyPath = config.sops.secrets.minecraft-api-key.path;
  };
}

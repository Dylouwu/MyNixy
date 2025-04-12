{ config, ... }: {
  services.glance-minecraft-power = {
    enable = true;
    minecraftServerName = "paradisum";
    apiKeyPath = config.sops.secrets.minecraft-api-key.path;
  };
}

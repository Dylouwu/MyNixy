{ config, ... }: {
  services.glance-minecraft-power = {
    enable = true;
    apiKeyPath = config.sops.secrets.minecraft-api-key.path;
  };
}

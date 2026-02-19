{ config, ... }: {
  services.glance-minecraft-power = {
    enable = true;
    minecraftServerName = "cobblemon";
    apiKeyPath = config.sops.secrets.minecraft-api-key.path;
  };
}

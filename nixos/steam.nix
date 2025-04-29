{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  environment.systemPackages = with pkgs; [ mangohud protonup ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/${config.var.username}/.steam/root/compatibilitytools.d";
  };

  programs.gamemode.enable = true;
  # Example of recommanded launch options for your games in Steam :
  # LD_PRELOAD="" gamescope -W 2560 -H 1440 -r 240 -f -- %command%

  # LD_PRELOAD="" removes a glitch causing games to slow down after roughly 24 minutes
  # For the rest of the command, you can change the values to match your screen resolution and refresh rate
}

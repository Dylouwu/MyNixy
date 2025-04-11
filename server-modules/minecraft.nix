{ pkgs, inputs, ... }: {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/var/lib/minecraft";

    servers = {
      paradisum = {
        autoStart = false;
        enable = true;
        enableReload = true;
        #jvmOpts =
        #  "-Xms16G -Xmx16G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxGCPauseMillis=50 -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:G1HeapRegionSize=32M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15";
        package = pkgs.paperServers.paper-1_21_1;
        restart = "no";
        serverProperties = {
          allow-nether = false;
          difficulty = 2;
          enable-command-block = true;
          enforce-whitelist = true;
          gamemode = "survival";
          max-players = 30;
          motd = "SMP";
          player-idle-timeout = 15;
          spawn-protection = 0;
          simulation-distance = 12;
          view-distance = 12;
          white-list = true;
        };
        whitelist = { Pur1rin = "97f095e9-0b9d-4435-a65c-2285461bacbe"; };
      };
    };
  };
}

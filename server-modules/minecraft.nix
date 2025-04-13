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
        jvmOpts =
          "-Xms8192M -Xmx8192M -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=28 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1MixedGCCountTarget=3 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:SurvivorRatio=32 -XX:G1HeapWastePercent=5 -XX:MaxTenuringThreshold=1 -XX:+PerfDisableSharedMem -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:+UseNUMA -XX:-DontCompileHugeMethods -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:ReservedCodeCacheSize=400M -XX:NonNMethodCodeHeapSize=12M -XX:ProfiledCodeHeapSize=194M -XX:NonProfiledCodeHeapSize=194M -XX:NmethodSweepActivity=1 -XX:+UseFastUnorderedTimeStamps -XX:+UseCriticalJavaThreadPriority -XX:AllocatePrefetchStyle=3 -XX:+AlwaysActAsServerClassMachine -XX:+UseTransparentHugePages -XX:LargePageSizeInBytes=2M -XX:+UseLargePages -XX:+EagerJVMCI -XX:+UseStringDeduplication -XX:+UseAES -XX:+UseAESIntrinsics -XX:+UseFMA -XX:+UseLoopPredicate -XX:+RangeCheckElimination -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseThreadPriorities -XX:+OmitStackTraceInFastThrow -XX:+RewriteBytecodes -XX:+RewriteFrequentPairs -XX:+UseFPUForSpilling -XX:+UseFastStosb -XX:+UseNewLongLShift -XX:+UseVectorCmov -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll -XX:+EliminateLocks -XX:+DoEscapeAnalysis -XX:+AlignVector -XX:+OptimizeFill -XX:+EnableVectorSupport -XX:+UseCharacterCompareIntrinsics -XX:+UseCopySignIntrinsic -XX:+UseVectorStubs -XX:UseAVX=2 -XX:UseSSE=4 -XX:+UseFastJNIAccessors -XX:+UseInlineCaches -XX:+SegmentedCodeCache";
        package = pkgs.paperServers.paper-1_21_1;
        restart = "no";
        serverProperties = {
          allow-nether = false;
          difficulty = 2;
          enable-command-block = true;
          enforce-whitelist = true;
          gamemode = "survival";
          max-players = 30;
          motd = "Welcome to Paradisum SMP !";
          player-idle-timeout = 15;
          spawn-protection = 0;
          simulation-distance = 5;
          view-distance = 12;
          white-list = true;
        };
        symlinks = {
          "cache/mojang_1.21.1.jar" =
            "${pkgs.vanillaServers.vanilla-1_21_1}/lib/minecraft/server.jar";
        };
        files = {
          "ops.json".value = [{
            name = "Pur1rin";
            uuid = "97f095e9-0b9d-4435-a65c-2285461bacbe";
            level = 4;
            bypassesPlayerLimit = true;
          }];
          "bukkit.yml".value = {
            spawn-limits = {
              monster = 40;
              animals = 10;
              water-animals = 4;
              water-ambient = 4;
              water-underground-creature = 6;
              axolotls = 4;
              ambient = 4;
            };
            ticks-per = {
              animal-spawns = 400;
              monster-spawns = 10;
              water-ambient-spawns = 400;
              water-underground-creature-spawns = 400;
              water-animals-spawns = 400;
              ambient-spawns = 400;
              axolotl-spawns = 400;
            };
          };
          "spigot.yml".value = {
            world-settings = {
              default = {
                mob-spawn-range = 4;
                entity-activation-range = {
                  animals = 24;
                  monsters = 32;
                  raiders = 48;
                  misc = 16;
                  water = 16;
                  villagers = 24;
                  flying-monsters = 48;
                };
                entity-tracking-range = {
                  players = 96;
                  animals = 64;
                  monsters = 64;
                  misc = 32;
                  other = 64;
                };
              };
            };
            messages.unknown-command = "Unknown command, dummy!";
          };
          "config/paper-world-defaults.yml".value = {
            chunk = {
              max-auto-save-chunks-per-tick = 10;
              prevent-moving-into-unloaded-chunks = true;
              entity-per-chunk-save-limit = {
                area_effect_cloud = 8;
                arrow = 16;
                breeze_wind_charge = 8;
                dragon_fireball = 3;
                egg = 8;
                ender_pearl = 8;
                experience_bottle = 3;
                experience_orb = 16;
                eye_of_ender = 8;
                fireball = 8;
                firework_rocket = 8;
                llama_spit = 3;
                potion = 8;
                shulker_bullet = 8;
                small_fireball = 8;
                snowball = 8;
                spectral_arrow = 16;
                trident = 16;
                wind_charge = 8;
                wither_skull = 4;
              };
            };
          };
        };
        whitelist = { Pur1rin = "97f095e9-0b9d-4435-a65c-2285461bacbe"; };
      };
    };
  };
}

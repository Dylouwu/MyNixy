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
          "-Xms16384M -Xmx16384M -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=28 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1MixedGCCountTarget=3 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:SurvivorRatio=32 -XX:G1HeapWastePercent=5 -XX:MaxTenuringThreshold=1 -XX:+PerfDisableSharedMem -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:+UseNUMA -XX:-DontCompileHugeMethods -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:ReservedCodeCacheSize=400M -XX:NonNMethodCodeHeapSize=12M -XX:ProfiledCodeHeapSize=194M -XX:NonProfiledCodeHeapSize=194M -XX:NmethodSweepActivity=1 -XX:+UseFastUnorderedTimeStamps -XX:+UseCriticalJavaThreadPriority -XX:AllocatePrefetchStyle=3 -XX:+AlwaysActAsServerClassMachine -XX:+UseTransparentHugePages -XX:LargePageSizeInBytes=2M -XX:+UseLargePages -XX:+EagerJVMCI -XX:+UseStringDeduplication -XX:+UseAES -XX:+UseAESIntrinsics -XX:+UseFMA -XX:+UseLoopPredicate -XX:+RangeCheckElimination -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseThreadPriorities -XX:+OmitStackTraceInFastThrow -XX:+RewriteBytecodes -XX:+RewriteFrequentPairs -XX:+UseFPUForSpilling -XX:+UseFastStosb -XX:+UseNewLongLShift -XX:+UseVectorCmov -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll -XX:+EliminateLocks -XX:+DoEscapeAnalysis -XX:+AlignVector -XX:+OptimizeFill -XX:+EnableVectorSupport -XX:+UseCharacterCompareIntrinsics -XX:+UseCopySignIntrinsic -XX:+UseVectorStubs -XX:UseAVX=2 -XX:UseSSE=4 -XX:+UseFastJNIAccessors -XX:+UseInlineCaches -XX:+SegmentedCodeCache";
        package = pkgs.paperServers.paper-1_21_5-build_114;
        restart = "no";
        serverProperties = {
          allow-nether = true;
          difficulty = 2;
          enable-command-block = true;
          enforce-whitelist = true;
          gamemode = "survival";
          max-chained-neighbor-updates = 100000;
          max-players = 30;
          motd =
            "\\u00a78\\u00a7l      \\u00a7m--<\\u00a7d\\u00a7l\\u00a7m-----\\u00a7r\\u00a7l \\u00a7b\\u00a7lParadisum\\u00a7r\\u00a7l \\u00a7d\\u00a7l\\u00a7m-----\\u00a78\\u00a7l\\u00a7m>--\\u00a7r\\n\\u00a7e     \\u228f\\u00a76\\u26ab\\u00a7e\\u2290 \\u00a7f\\u00a7l\\u00a76\\u00a7l\\u00a7nWelcome\\u00a7f\\u00a7l ! 1.21.5 Private SMP\\u00a7e \\u228f\\u00a76\\u26ab\\u00a7e\\u2290";
          player-idle-timeout = 30;
          resource-pack =
            "https://download.mc-packs.net/pack/4e580104713aecfd5e9eb3dd6f4e988c701e7eea.zip";
          resource-pack-sha1 = "4e580104713aecfd5e9eb3dd6f4e988c701e7eea";
          require-resource-pack = true;
          spawn-protection = 0;
          simulation-distance = 6;
          view-distance = 12;
          white-list = true;
        };
        whitelist = {
          Pur1rin = "97f095e9-0b9d-4435-a65c-2285461bacbe";
          Pikimo = "ee7137da-817a-4c59-81b9-965f03b723e9";
          PabloV = "8b6c93fa-a7df-4cc8-9cb5-d708af59bad5";
          Ayzvenx = "47882024-633f-4df6-8fd8-7d9eb02a72b7";
          iimapinguin = "45ba223f-1a1a-49b9-a140-0b9a03473fad";
          ThomTheom = "fdbd4b7e-b6a5-4176-8e31-dea3629795ef";
          Shrekommunist = "99c55b33-26c6-43ed-a134-f02f0a3ca75e";
          BriocheSucree = "554c22ba-e518-4206-8e1a-8d99d067d720";
          HadrienAka = "5d65b248-a2da-4109-bfdf-9051417d9a6a";
          warrameur12 = "bf4d52a5-53ef-4b1b-9ac0-b805db20b537";
          Rettleti = "bf4d52a5-53ef-4b1b-9ac0-b805db20b537";
          lulu5587 = "f15a6b3d-93bf-4c00-ac87-3e911ea9bb37";
          Cinyu202 = "8b94b50d-136e-4477-b240-58aae8e957b0";
          Jujuhilo = "251b583b-4a2f-40ed-92df-8f3f7ad701a7";
          PablitoChangJose = "029a7510-65b1-4f48-a5f4-2482b62a2f4d";
          qmiho = "a5b83881-bc45-449e-9136-09209ac42c86";
          Baiocch = "e89c1a21-7fea-4599-907c-c1f1b03bed94";
          Arc_a_Nain = "97938b8f-4390-42da-ba8c-a93d33444e22";
          zouu = "cf4c6d5e-0cbc-4574-b839-7c2efc3ee6d1";
          Evo_Termii = "62fb868b-4031-451b-a8f7-5eec12a48c10";
          Pinpinnation = "fa98e9f9-c3b4-46c9-8540-bbab5157b3a4";
        };

        symlinks = {
          "cache/mojang_1.21.5.jar" =
            "${pkgs.vanillaServers.vanilla-1_21_5}/lib/minecraft/server.jar";
        };

        files = {
          "world/datapacks" = builtins.path {
            path = inputs.minecraft-datapacks;
            name = "datapacks";
          };
          "server-icon.png" = ../src/cherry.png;
          "ops.json".value = [{
            name = "Pur1rin";
            uuid = "97f095e9-0b9d-4435-a65c-2285461bacbe";
            level = 4;
            bypassesPlayerLimit = true;
          }];
          "bukkit.yml".value = {
            spawn-limits = {
              monsters = 70;
              animals = 15;
              water-animals = 10;
              water-ambient = 10;
              water-underground-creature = 10;
              axolotls = 6;
              ambient = 3;
            };
            ticks-per = {
              animal-spawns = 400;
              monster-spawns = 1;
              water-ambient-spawns = 400;
              water-underground-creature-spawns = 400;
              water-spawns = 400;
              ambient-spawns = 400;
              axolotl-spawns = 400;
            };
          };
          "spigot.yml".value = {
            commands.spam-exclusions = [ ];
            world-settings = {
              default = {
                mob-spawn-range = 5;
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
                  monsters = 48;
                  misc = 32;
                  other = 64;
                };
                merge-radius = {
                  item = 1.5;
                  exp = 1.5;
                };
              };
            };
            messages.unknown-command = "Unknown command, dummy!";
          };
          "config/paper-global.yml".value = {
            item-validation.book-size.page-max = 1024;
            packet-limiter.overrides = {
              ServerboundCommandSuggestionPacket = {
                action = "DROP";
                interval = 1.0;
                max-packet-rate = 15.0;
              };
              ServerboundPlaceRecipePacket = {
                action = "DROP";
                interval = 4.0;
                max-packet-rate = 5.0;
              };
            };
            misc.max-joins-per-tick = 3;
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
            collisions = {
              max-entity-collisions = 4;
              fix-climbing-bypassing-cramming-rule = true;
            };
            misc = {
              update-pathfinding-on-block-update = false;
              redstone-implementation = "ALTERNATE_CURRENT";
            };
            entities = {
              armor-stands = {
                tick = false;
                do-collision-entity-lookups = false;
              };
              spawning = {
                non-player-arrow-despawn-rate = 100;
                creative-arrow-despawn-rate = 100;
                alt-item-despawn-rate = {
                  enabled = true;
                  items = {
                    cobblestone = 600;
                    netherrack = 600;
                    sand = 600;
                    red_sand = 600;
                    gravel = 600;
                    dirt = 600;
                    short_grass = 600;
                    kelp = 1200;
                    bamboo = 1200;
                    sugar_cane = 1200;
                    twisting_vines = 600;
                    weeping_vines = 600;
                    oak_leaves = 600;
                    spruce_leaves = 600;
                    birch_leaves = 600;
                    jungle_leaves = 600;
                    acacia_leaves = 600;
                    dark_oak_leaves = 600;
                    mangrove_leaves = 600;
                    cherry_leaves = 600;
                    azalea_leaves = 600;
                    cactus = 600;
                    diorite = 600;
                    granite = 600;
                    andesite = 600;
                  };
                };
                despawn-ranges = {
                  ambient = {
                    hard = 96;
                    soft = 36;
                  };
                  axolotls = {
                    hard = 96;
                    soft = 36;
                  };
                  creature = {
                    hard = 96;
                    soft = 36;
                  };
                  misc = {
                    hard = 96;
                    soft = 36;
                  };
                  monster = {
                    hard = 96;
                    soft = 36;
                  };
                  underground_water_creature = {
                    hard = 96;
                    soft = 36;
                  };
                  water_ambient = {
                    hard = 96;
                    soft = 36;
                  };
                  water_creature = {
                    hard = 96;
                    soft = 36;
                  };
                };
              };
            };
            environment = { optimize-explosions = true; };
            tick-rates = {
              grass-spread = 4;
              mob-spawner = 2;
              behavior.villager = {
                validatenearbypoi = 60;
                acquirepoi = 120;
              };
              sensor.villager = {
                secondarypoisensor = 80;
                nearestbedsensor = 80;
                villagerbabiessensor = 40;
                playersensor = 40;
                nearestlivingentitysensor = 40;
              };
            };
          };
        };
      };
    };
  };
}

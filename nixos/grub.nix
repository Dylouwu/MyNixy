{ pkgs, lib, ... }: {
  boot = {
    bootspec.enable = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        minegrub-world-sel = {
          enable = true;

          customIcons = [
            {
              name = "nixos";
              lineTop = "Nixy";
              lineBottom = "Creative Mode, Cheats, Version: Unstable";
              imgName = "nixos";
              customImg = builtins.path {
                path = ../src/cherry.png;
                name = "Cherry";
              };
            }
            {
              name = "windows";
              lineTop = "Windows 11";
              lineBottom = "Survival Mode, No Cheats, Version: 24H2";
              imgName = "windows";
              customImg = builtins.path {
                path = ../src/blue.png;
                name = "Blue";
              };
            }
          ];
        };
        enable = true;
        splashImage = ../src/loading.png;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "1024x768";
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;

    plymouth = {
      enable = true;
      theme = lib.mkForce "green_blocks";
      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "green_blocks" ];
          })
        ];
    };
  };
}

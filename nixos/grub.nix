{ pkgs, ... }: {
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      # systemd-boot = {
      #   enable = true;
      #   consoleMode = "auto";
      #   configurationLimit = 8;
      # };
      grub = {
        minegrub-world-sel = {
          enable = true;

          customIcons = [
            {
              name = "nixos";
              lineTop = "Nixy";
              lineBottom = "Creative Mode, Cheats, Version: Unstable";
              # Icon: you can use an icon from the remote repo, or load from a local file
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
    kernelPackages =
      pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.

    # Silent boot
    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}

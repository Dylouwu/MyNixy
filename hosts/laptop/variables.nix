{ config, lib, ... }: {
  imports = [
    # Import your stylix theme
    ../../themes/rose-pine.nix
  ];

  config.var = {
    hostname = "nixy";
    username = "dilounix"; # CHANGEME: Your username
    configDirectory = "/home/" + config.var.username + "/.config/nixos";
    keyboardLayout = "fr";
    location = "Paris";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "fr_FR.UTF-8";
    monitors = {
      monitor1 = { # External monitor, which is only active when docked
        id = "HDMI-A-1";
        width = 2560;
        height = 1440;
        fps = 360;
        scale = 1;
      };
      monitor2 = { # Laptop screen, which is always active
        id = "eDP-2";
        width = 2560;
        height = 1440;
        fps = 240;
        scale = 1;
      };
    };
    git = {
      username = "Purin";
      email = "118902463+Dylouwu@users.noreply.github.com";
    };
    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  options = {
    var = {
      hostname = lib.mkOption { type = lib.types.str; };
      username = lib.mkOption { type = lib.types.str; };
      configDirectory = lib.mkOption { type = lib.types.str; };
      keyboardLayout = lib.mkOption { type = lib.types.str; };
      location = lib.mkOption { type = lib.types.str; };
      timeZone = lib.mkOption { type = lib.types.str; };
      defaultLocale = lib.mkOption { type = lib.types.str; };
      extraLocale = lib.mkOption { type = lib.types.str; };
      monitors = lib.mkOption {
        type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
      };
      git = lib.mkOption { type = lib.types.attrs; };
      autoUpgrade = lib.mkOption { type = lib.types.bool; };
      autoGarbageCollector = lib.mkOption { type = lib.types.bool; };
    };
  };
}

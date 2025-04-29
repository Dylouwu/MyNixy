{ config, lib, ... }: {
  imports = [ ../../themes/nixy.nix ];

  config.var = {
    hostname = "hyrule";
    username = "dilounix"; # CHANGEME: Your username
    configDirectory = "/home/" + config.var.username + "/.config/nixos";
    keyboardLayout = "fr";

    location = "Paris";
    timeZone = "Europe/Paris";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "fr_FR.UTF-8";

    git = {
      username = "Purin";
      email = "118902463+Dylouwu@users.noreply.github.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}

{ config, ... }:
let keyboardLayout = config.var.keyboardLayout;
in {
  services = {
    xserver = {
      enable = true;
      xkb.layout = keyboardLayout;
      xkb.variant = "";
    };

    gnome.gnome-keyring.enable = true;

    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}

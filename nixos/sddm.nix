{ pkgs, config, inputs, ... }:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
    themeConfig = {
      ScreenWidth = config.var.monitors.monitor1.width;
      ScreenHeight = config.var.monitors.monitor1.height;
      HideVirtualKeyboard = true;
      HideSystemButtons = false;
      HideLoginButton = true;
    };
  };
in {
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      extraPackages = [ sddm-astronaut ];
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      settings = {
        Wayland.SessionDir = "${
            inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland
          }/share/wayland-sessions";
      };
    };
  };

  environment.systemPackages = [ sddm-astronaut ];

  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}

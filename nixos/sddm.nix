{ pkgs, inputs, ... }:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
    themeConfig = {
      ScreenWidth = 2560;
      ScreenHeight = 1440;
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
            inputs.hyprland.packages."${pkgs.system}".hyprland
          }/share/wayland-sessions";
      };
    };
  };

  environment.systemPackages = [ sddm-astronaut ];

  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}

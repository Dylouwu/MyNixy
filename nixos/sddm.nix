{ pkgs, inputs, ... }:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
    themeConfig = { };
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

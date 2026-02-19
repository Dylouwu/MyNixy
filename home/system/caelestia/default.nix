# Caelestia Shell Home Manager Configuration
# See https://github.com/caelestia-dots/shell
{ pkgs, inputs, ... }:
{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    ./appearance.nix
    ./bar.nix
    ./bindings.nix
    ./launcher.nix
    ./scheme.nix
  ];

  programs.caelestia = {
    enable = true;
    systemd.enable = false;
    settings = {
      general = {
        apps = {
          terminal = [ "kitty" ];
          audio = [ "pwvucontrol" ];
          explorer = [ "thunar" ];
        };
        idle = {
          timeouts = [ ];
        };
      };

      notifs.actionOnClick = true;
      services = {
        brightnessIncrement = 0.05;
        defaultPlayer = "YT Music";
        useTwelveHourClock = false;
        weatherLocation = "Paris";
      };
    };
    cli = {
      enable = true;
      settings.theme = {
        enableTerm = false;
        enableDiscord = false;
        enableSpicetify = false;
        enableBtop = true;
        enableCava = false;
        enableHypr = false;
        enableGtk = false;
        enableQt = false;
      };
    };
  };

  home.packages = with pkgs; [ gpu-screen-recorder ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app -- caelestia resizer -d"
    "uwsm app -- caelestia shell -d"
    "caelestia scheme set --name dynamic -m dark"
  ];
}

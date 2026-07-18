{ pkgs, config, ... }:
let
  inherit (config.stylix) fonts;
in
{
  home.packages = with pkgs; [ papirus-icon-theme ];

  programs.caelestia.settings = {
    appearance = {
      transparency = {
        base = 0.85;
        layers = 0.4;
      };
      font = {
        headline.family = fonts.sansSerif.name;
        title.family = fonts.sansSerif.name;
        body.family = fonts.sansSerif.name;
        label.family = fonts.sansSerif.name;
        mono.family = fonts.monospace.name;
      };
    };
    border.thickness = 8;
    dashboard = {
      showOnHover = false;
    };
    lock = {
      recolourLogo = true;
      enableFprint = false;
    };
    paths = {
      mediaGif = ./src/gifs/bongocat.gif;
      sessionGif = ./src/gifs/kurukuru.gif;
      wallpaperDir = ./src/wallpapers;
    };
    utilities = {
      enabled = true;
      maxToasts = 4;
      toasts = {
        audioInputChanged = false;
        audioOutputChanged = false;
        capsLockChanged = false;
        chargingChanged = true;
        configLoaded = false;
        dndChanged = true;
        gameModeChanged = true;
        numLockChanged = false;
        nowPlaying = false;
        kbLayoutChanged = false;
        vpnChanged = true;
      };
    };
  };
}

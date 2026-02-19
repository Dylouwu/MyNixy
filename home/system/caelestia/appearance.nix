{ pkgs, config, ... }:
let
  inherit (config.stylix) fonts;
in
{
  home.packages = with pkgs; [ papirus-icon-theme ];

  programs.caelestia.settings = {
    appearance = {
      transparency = {
        enable = true;
        base = 0.85;
        layers = 0.4;
      };
      font.family = {
        material = "Material Symbols Rounded";
        mono = fonts.monospace.name;
        sans = fonts.sansSerif.name;
      };
    };
    border.thickness = 8;
    controlCenter.sizes.heightMult = 0.6;
    dashboard = {
      showOnHover = false;
    };
    lock = {
      recolourLogo = true;
      enableFprint = false;
      sizes = {
        heightMult = 0.7;
        centerWidth = 600;
      };
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
      wInfo.sizes = {
        heightMult = 0.6;
        centerWidth = 520;
      };
    };
  };
}

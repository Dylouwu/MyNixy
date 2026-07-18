{ pkgs, inputs, ... }:

let

  qylock-theme = pkgs.stdenv.mkDerivation {
    name = "qylock-theme";
    src = pkgs.fetchFromGitHub {
      owner = "Darkkal44";
      repo = "qylock";
      rev = "3ecb79f621d5bfc2fbc6bfd37c3b12f0214601ac";
      hash = "sha256-NfCuiVlJsXp3k1nK9XieKdL0v/pbiMKfyU5A3Gc3fpk=";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes/girl-pillow
      cp -r themes/girl-pillow/. $out/share/sddm/themes/girl-pillow
    '';
  };
in
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;

      theme = "girl-pillow";

      extraPackages = with pkgs; [
        qylock-theme
        kdePackages.qtdeclarative
        kdePackages.qt5compat
        kdePackages.qtmultimedia
      ];

      settings = {
        Wayland.SessionDir = "${
          inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland
        }/share/wayland-sessions";
      };
    };
  };

  environment.systemPackages = [ qylock-theme ];

  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}

# - ## Powermode-Toggle
# -
# - This script toggles between performance and balanced power modes using `powerprofilesctl`.
{ pkgs, ... }:
let
  powermode-toggle = pkgs.writeShellScriptBin "powermode-toggle" # bash
    ''
      current_profile=$(powerprofilesctl get)
      if [ "$current_profile" = "performance" ]; then
        powerprofilesctl set balanced
        notif "powermode" "󰗑 Balanced Mode Activated" "Enjoy the balance!"
      else
        powerprofilesctl set performance
        notif "powermode" "󱐋 Performance Mode Activated" "Enjoy the power!"
      fi
    '';
in { home.packages = [ powermode-toggle ]; }

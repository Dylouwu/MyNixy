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
        ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --custom-message="Powermode set to balanced" --custom-icon="emblem-default"
      else
        powerprofilesctl set performance
        ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --custom-message="Powermode set to performance" --custom-icon="emblem-default"
      fi
    '';
in { home.packages = [ powermode-toggle ]; }

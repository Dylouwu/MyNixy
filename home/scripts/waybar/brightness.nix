# - ## Brightness
#- 
#- This module provides a set of scripts to control the brightness of the screen.
#-
#- - `brightness-up` increases the brightness by 5%.
#- - `brightness-down` decreases the brightness by 5%.
#- - `brightness-set [value]` sets the brightness to the given value.
#- - `brightness-change [up|down] [value]` increases or decreases the brightness by the given value.

{ pkgs, ... }:

let
  brightness-change = pkgs.writeShellScriptBin "brightness-change" ''
    [[ $1 == "up" ]] && ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --brightness raise
    [[ $1 == "down" ]] && ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --brightness lower
  '';

  brightness-set = pkgs.writeShellScriptBin "brightness-set" ''
    ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --brightness ''${1-100}
  '';

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ''
    brightness-change up
  '';

  brightness-down = pkgs.writeShellScriptBin "brightness-down" ''
    brightness-change down
  '';

in {
  home.packages =
    [ brightness-change brightness-up brightness-down brightness-set ];
}

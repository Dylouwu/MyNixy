# - ## Sound
#-
#- This module provides a set of scripts to control the volume of the default audio sink using `wpctl`.
#-
#- - `sound-up` increases the volume by 5%.
#- - `sound-down` decreases the volume by 5%.
#- - `sound-set [value]` sets the volume to the given value.
#- - `sound-toggle` toggles the mute state of the default audio sink.
{ pkgs, ... }:

let
  sound-change = pkgs.writeShellScriptBin "sound-change" ''
    [[ $1 == "mute" ]] && ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --output-volume mute-toggle
    [[ $1 == "up" ]] && ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --output-volume raise
    [[ $1 == "down" ]] && ${pkgs.swayosd}/bin/swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" --output-volume lower
  '';

  sound-up = pkgs.writeShellScriptBin "sound-up" ''
    sound-change up 
  '';

  sound-down = pkgs.writeShellScriptBin "sound-down" ''
    sound-change down 
  '';

  sound-toggle = pkgs.writeShellScriptBin "sound-toggle" ''
    sound-change mute
  '';
in { home.packages = [ sound-change sound-up sound-down sound-toggle ]; }

{ pkgs, config, ... }:
let
  configDirectory = config.var.configDirectory;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod,RETURN, exec, uwsm app -- ${pkgs.kitty}/bin/kitty" # Kitty
      "$mod,E, exec, uwsm app -- ${pkgs.thunar}/bin/thunar" # Thunar
      "$mod,B, exec, uwsm app -- zen" # Zen Browser
      "$mod,S, exec, uwsm app -- steam" # Steam
      "$mod,SPACE, global, caelestia:launcher" # Launcher
      "$mod,X, global, caelestia:session" # Powermenu
      "$mod,L, exec, hyprctl dispatch global caelestia:lock" # Lock
      "$mod,N, exec, caelestia shell drawers toggle sidebar" # Toggle sidebar
      "$mod,D, exec, caelestia shell drawers toggle dashboard" # Toggle dashboard

      "$mod,Q, killactive," # Close window
      "$mod,T, togglefloating," # Toggle Floating
      "$mod,F, fullscreen" # Toggle Fullscreen
      ",F11, fullscreen" # Toggle Fullscreen
      "$mod,left, movefocus, l" # Move focus left
      "$mod,right, movefocus, r" # Move focus Right
      "$mod,up, movefocus, u" # Move focus Up
      "$mod,down, movefocus, d" # Move focus Down

      "$mod,PRINT, global, caelestia:screenshot" # Screenshot
      "ALT,PRINT, global, caelestia:screenshot" # Screenshot
      ",PRINT, global, caelestia:screenshotFreeze" # Screenshot with freeze
      "$shiftMod,S, global, caelestia:screenshotFreeze" # Screenshot with freeze

      "$mod,W, exec, caelestia wallpaper -r ${configDirectory}/home/system/caelestia/src/wallpapers"
      "$shiftMod,E, exec, pkill fuzzel || caelestia emoji -p" # Emoji picker
      "$mod,F2, exec, nightshift-toggle" # Toggle night shift
    ]
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod,code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 9
    ));

    bindm = [
      "$mod,mouse:272, movewindow" # Move Window (mouse)
      "$mod,R, resizewindow" # Resize Window (mouse)
    ];

    bindl = [
      # Brightness
      ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
      ", XF86MonBrightnessDown, global, caelestia:brightnessDown"

      # Media
      ", XF86AudioPlay, global, caelestia:mediaToggle"
      ", XF86AudioPause, global, caelestia:mediaToggle"
      ", XF86AudioNext, global, caelestia:mediaNext"
      ", XF86AudioPrev, global, caelestia:mediaPrev"
      ", XF86AudioStop, global, caelestia:mediaStop"

      # Sound
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bindin = [
      # Launcher
      "$mod, mouse:272, global, caelestia:launcherInterrupt"
      "$mod, mouse:273, global, caelestia:launcherInterrupt"
      "$mod, mouse:274, global, caelestia:launcherInterrupt"
      "$mod, mouse:275, global, caelestia:launcherInterrupt"
      "$mod, mouse:276, global, caelestia:launcherInterrupt"
      "$mod, mouse:277, global, caelestia:launcherInterrupt"
      "$mod, mouse_up, global, caelestia:launcherInterrupt"
      "$mod, mouse_down, global, caelestia:launcherInterrupt"
      "$mod, , global, caelestia:launcherInterrupt"
    ];
  };
}

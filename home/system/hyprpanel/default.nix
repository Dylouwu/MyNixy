# Hyprpanel is the bar on top of the screen
# Display informations like workspaces, battery, wifi, ...
{ config, lib, ... }:
let
  inherit (config.lib.stylix.colors)
    base00
    base01
    base03
    base05
    base0D
    ;
  inherit (config.stylix.fonts) serif;
  inherit (config.theme.bar)
    floating
    transparent
    position
    transparentButtons
    ;
  inherit (config.theme)
    rounding
    border-size
    gaps-out
    gaps-in
    textColorOnWallpaper
    ;

  accent = "#${base0D}";
  accent-alt = "#${base03}";
  background = "#${base00}";
  background-alt = "#${base01}";
  foreground = "#${base05}";
  foregroundOnWallpaper = "#${textColorOnWallpaper}";

  font = serif.name;
  fontSizeForHyprpanel = "${toString config.stylix.fonts.sizes.desktop}px";
  notificationOpacity = 90;
  location = config.var.location;
  weather-key = "/home/${config.var.username}/.weather.json";

  noOpacity = "00";
  barBg = background + (if transparentButtons && transparent then noOpacity else "");
  buttonBg =
    (if transparent then background else background-alt)
    + (if transparentButtons then noOpacity else "");
  buttonText = if transparent && transparentButtons then foregroundOnWallpaper else foreground;

in
{
  imports = [
    ../../misc
  ];
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprpanel" ];

  programs.hyprpanel = {
    enable = true;

    settings = {
      scalingPriority = "hyprland";
      theme = lib.mkForce {
        font = {
          inherit font;
          size = fontSizeForHyprpanel;
        };

        bar = {
          outer_spacing = if floating && transparent then "0px" else "8px";
          inherit floating transparent position;
          location = position;
          margin_top = (if position == "top" then toString (gaps-in * 2) else "0") + "px";
          margin_bottom = (if position == "top" then "0" else toString (gaps-in * 2)) + "px";
          margin_sides = toString gaps-out + "px";
          border_radius = toString rounding + "px";
          dropdownGap = "4.5em";
          background = barBg;

          buttons = lib.mkForce {
            y_margins = if floating && transparent then "0px" else "8px";
            spacing = "0.3em";
            radius = (if transparent then toString rounding else toString (rounding - 8)) + "px";
            padding_x = "0.8rem";
            padding_y = "0.4rem";
            style = "default";
            monochrome = true;
            text = buttonText;
            background = buttonBg;
            icon = accent;
            hover = background;
            workspaces = {
              hover = accent-alt;
              active = accent;
              available = accent-alt;
              occupied = accent-alt;
            };
            notifications = {
              background = background-alt;
              hover = background;
              total = accent;
              icon = accent;
            };
          };

          menus = lib.mkForce {
            shadow = if transparent then "0 0 0 0" else "0px 0px 3px 1px #16161e";
            monochrome = true;
            card_radius = toString rounding + "px";
            background = background;
            cards = background-alt;
            label = foreground;
            text = foreground;
            listitems.active = accent;
            icons.active = accent;
            switch.enabled = accent;
            check_radio_button.active = accent;
            progressbar.foreground = accent;
            slider.primary = accent;
            border = {
              size = toString border-size + "px";
              radius = toString rounding + "px";
              color = accent;
            };
            menu.media = {
              card.tint = 90;
              background.color = background-alt;
              card.color = background-alt;
            };
            popover = {
              inherit foreground;
              background = background-alt;
              text = foreground;
            };
            tooltip = {
              background = background-alt;
              text = foreground;
            };
            dropdownmenu = {
              background = background-alt;
              text = foreground;
            };
            buttons = {
              default = accent;
              active = accent;
            };
            iconbuttons.active = accent;
          };
        };

        notification = {
          inherit notificationOpacity;
          enableShadow = true;
          border_radius = toString rounding + "px";
          background = background-alt;
          label = accent;
          border = background-alt;
          text = foreground;
          labelicon = accent;
          actions = {
            background = accent;
            text = foreground;
          };
          close_button = {
            background = background-alt;
            label = "#f38ba8";
          };
        };

        osd = {
          enable = true;
          orientation = "vertical";
          location = "left";
          radius = toString rounding + "px";
          margins = "0px 0px 0px 10px";
          muted_zero = true;
          bar_color = accent;
          bar_overflow_color = accent-alt;
          icon = background;
          icon_container = accent;
          label = accent;
          bar_container = background-alt;
        };
      };

      bar = {
        layouts = {
          "*" = {
            "left" = [
              "dashboard"
              "workspaces"
              "windowtitle"
            ];
            "middle" = [
              "media"
              "cava"
            ];
            "right" = [
              "systray"
              "volume"
              "battery"
              "network"
              "clock"
              "notifications"
            ];
          };
        };
        launcher.icon = "";
        workspaces = {
          show_numbered = false;
          workspaces = 1;
          numbered_active_indicator = "color";
          monitorSpecific = false;
          applicationIconEmptyWorkspace = "";
          showApplicationIcons = true;
          showWsIcons = true;
        };
        windowtitle.label = true;
        volume.label = false;
        network.truncation_size = 12;
        bluetooth.label = false;
        clock.format = "%a %b %d  %I:%M %p";
        notifications.show_total = true;
        media.show_active_only = true;
        customModules = {
          updates.pollingInterval = 1440000;
          cava = {
            showIcon = false;
            stereo = true;
            showActiveOnly = true;
          };
        };
      };

      notifications = {
        position = "top right";
        showActionsOnHover = true;
      };

      menus = {
        clock.weather = {
          inherit location;
          unit = "metric";
          key = weather-key;
        };
        dashboard = {
          directories.enabled = false;
          powermenu = {
            confirmation = false;
            avatar.image = "~/.face.icon";
          };
          shortcuts = {
            left = {
              shortcut1 = {
                icon = "";
                command = "zen";
                tooltip = "Zen";
              };
              shortcut2 = {
                icon = "󰅶";
                command = "caffeine";
                tooltip = "Caffeine";
              };
              shortcut3 = {
                icon = "󰖔";
                command = "nightshift-toggle";
                tooltip = "Night-shift";
              };
              shortcut4 = {
                icon = "";
                command = "menu";
                tooltip = "Search Apps";
              };
            };
            right = {
              shortcut1 = {
                icon = "";
                command = "hyprpicker -a";
                tooltip = "Color Picker";
              };
              shortcut3 = {
                icon = "󰄀";
                command = "screenshot region swappy";
                tooltip = "Screenshot";
              };
            };
          };
        };
        power.lowBatteryNotification = true;
      };

      wallpaper.enable = false;
    };
  };
}

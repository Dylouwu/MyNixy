# Hyprpanel is the bar on top of the screen
# Display informations like workspaces, battery, wifi, ...
{ config, ... }:
let
  transparentButtons = config.theme.bar.transparentButtons;
  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  foregroundOnWallpaper = "#${config.theme.textColorOnWallpaper}";
  font = "${config.stylix.fonts.serif.name}";
  fontSizeForHyprpanel = "${toString config.stylix.fonts.sizes.desktop}px";
  rounding = config.theme.rounding;
  border-size = config.theme.border-size;
  gaps-out = config.theme.gaps-out;
  gaps-in = config.theme.gaps-in;

  floating = config.theme.bar.floating;
  transparent = config.theme.bar.transparent;
  position = config.theme.bar.position; # "top" or "bottom"

  notificationOpacity = 90;
  location = config.var.location;
  weather-key = "/home/${config.var.username}/.weather.json";

in {
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprpanel" ];

  programs.hyprpanel = {
    enable = true;

    settings = {
      layout = {
        bar.layouts = {
          "*" = {
            "left" = [ "dashboard" "workspaces" "windowtitle" ];
            "middle" = [ "media" "cava" ];
            "right" = [ "systray" "volume" "bluetooth" "battery" "network" "clock" "notifications" ];
          };
        };
      };

      theme.font.name = font;
      theme.font.size = fontSizeForHyprpanel;
      theme.bar = {
        outer_spacing = if floating && transparent then "0px" else "8px";
        floating = floating;
        margin_top = (if position == "top" then toString (gaps-in * 2) else "0") + "px";
        margin_bottom = (if position == "top" then "0" else toString (gaps-in * 2)) + "px";
        margin_sides = toString gaps-out + "px";
        border_radius = toString rounding + "px";
        transparent = transparent;
        location = position;
        dropdownGap = "4.5em";
        background = background + (if transparentButtons && transparent then "00" else "");
      };

      theme.bar.buttons = {
        y_margins = if floating && transparent then "0px" else "8px";
        spacing = "0.3em";
        radius = (if transparent then toString rounding else toString (rounding - 8)) + "px";
        padding_x = "0.8rem";
        padding_y = "0.4rem";
        style = "default";
        monochrome = true;
        text = if transparent && transparentButtons then foregroundOnWallpaper else foreground;
        background = (if transparent then background else background-alt) + (if transparentButtons then "00" else "");
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

      theme.bar.menus = {
        shadow = if transparent then "0 0 0 0" else "0px 0px 3px 1px #16161e";
        monochrome = true;
        card_radius = toString rounding + "px";
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
        background = background;
        cards = background-alt;
        label = foreground;
        text = foreground;
        popover = {
          text = foreground;
          background = background-alt;
        };
        listitems.active = accent;
        icons.active = accent;
        switch.enabled = accent;
        check_radio_button.active = accent;
        buttons = {
          default = accent;
          active = accent;
        };
        iconbuttons.active = accent;
        progressbar.foreground = accent;
        slider.primary = accent;
        tooltip = {
          background = background-alt;
          text = foreground;
        };
        dropdownmenu = {
          background = background-alt;
          text = foreground;
        };
      };

      bar = {
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
      theme.notification = {
        opacity = notificationOpacity;
        enableShadow = true;
        border_radius = toString rounding + "px";
        background = background-alt;
        actions = {
          background = accent;
          text = foreground;
        };
        label = accent;
        border = background-alt;
        text = foreground;
        labelicon = accent;
        close_button = {
          background = background-alt;
          label = "#f38ba8";
        };
      };

      theme.osd = {
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

      menus = {
        clock.weather = {
          location = location;
          unit = "metric";
          key = weather-key;
        };
        dashboard = {
          powermenu = {
            confirmation = false;
            avatar.image = "~/.face.icon";
          };
          shortcuts = {
            left = {
              shortcut1 = { icon = ""; command = "zen"; tooltip = "Zen"; };
              shortcut2 = { icon = "󰅶"; command = "caffeine"; tooltip = "Caffeine"; };
              shortcut3 = { icon = "󰖔"; command = "night-shift"; tooltip = "Night-shift"; };
              shortcut4 = { icon = ""; command = "menu"; tooltip = "Search Apps"; };
            };
            right = {
              shortcut1 = { icon = ""; command = "hyprpicker -a"; tooltip = "Color Picker"; };
              shortcut3 = { icon = "󰄀"; command = "screenshot region swappy"; tooltip = "Screenshot"; };
            };
          };
        };
        power.lowBatteryNotification = true;
      };

      wallpaper.enable = false;
    };
  };
}

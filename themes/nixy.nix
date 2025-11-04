{ lib, pkgs, inputs, ... }: {

  options.theme = lib.mkOption {
    type = lib.types.attrs;
    default = {
      rounding = 16;
      gaps-in = 9;
      gaps-out = 9 * 2;
      active-opacity = 1;
      inactive-opacity = 0.93;
      blur = true;
      border-size = 3;
      animation-speed = "fast"; # "fast" | "medium" | "slow"
      fetch = "none"; # "nerdfetch" | "neofetch" | "pfetch" | "none"

      bar = {
        position = "top"; # "top" | "bottom"
        transparent = true;
        transparentButtons = false;
        floating = true;
      };
    };
    description = "Theme configuration options";
  };

  config = {
    stylix = {
      enable = true;

      # Edited catppuccin
      base16Scheme = {
        base00 = "10101a"; # Default Background
        base01 =
          "1c1c24"; # Lighter Background (Used for status bars, line number and folding marks)
        base02 = "2b2b2b"; # Selection Background
        base03 = "45475a"; # Comments, Invisibles, Line Highlighting
        base04 = "585b70"; # Dark Foreground (Used for status bars)
        base05 = "fcfcfc"; # Default Foreground, Caret, Delimiters, Operators
        base06 = "f5e0dc"; # Light Foreground (Not often used)
        base07 = "b4befe"; # Light Background (Not often used)
        base08 =
          "f38ba8"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
        base09 =
          "fab387"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
        base0A = "f9e2af"; # Classes, Markup Bold, Search Text Background
        base0B =
          "a6e3a1"; # Strings, Inherited Class, Markup Code, Diff Inserted
        base0C =
          "94e2d5"; # Support, Regular Expressions, Escape Characters, Markup Quotes
        base0D =
          "a594fd"; # Functions, Methods, Attribute IDs, Headings, Main purple color
        base0E =
          "cba6f7"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
        base0F =
          "f2cdcd"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrains Mono Nerd Font";
        };
        sansSerif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        serif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          applications = 13;
          desktop = 13;
          popups = 13;
          terminal = 13;
        };
      };

      image = pkgs.fetchurl {
        url =
          "https://raw.githubusercontent.com/anotherhadi/nixy-wallpapers/refs/heads/main/wallpapers/3.png";
        sha256 = "sha256-fT2ah18IAxoy3hzlLl9SkqhchzfVvZneUrZWzntMo40=";
      };

    };
  };

}

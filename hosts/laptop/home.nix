{ pkgs, config, ... }:
{

  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/nvim
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/nextcloud
    ../../home/programs/thunar
    ../../home/programs/lazygit
    ../../home/programs/zen
    ../../home/programs/tailscale
    ../../home/programs/zathura
    ../../home/programs/zellij

    # Scripts
    ../../home/scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/mime
    ../../home/system/udiskie

    # CHANGEME : Hyprland panels, you should only have one of these enabled at a time
    ../../home/system/caelestia
    #../../home/system/hyprpanel
    #../../home/system/waybar

    ./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      bitwarden-desktop # Password manager
      discord
      mpv # Video player
      curtail # Compress images
      prismlauncher
      osu-lazer-bin
      gnome-text-editor # Text editor

      # Dev
      clang
      libcxx
      go
      air
      jq
      just
      python3
      pnpm
      zulu

      # Utils
      file
      zip
      unzip
      btop
      pwvucontrol
      fastfetch
      openvpn
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = {
      source = ../../src/purin.jpg;
    };

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

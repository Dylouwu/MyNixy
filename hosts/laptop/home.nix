{ pkgs, config, ... }: {

  imports = [
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/nvim
    ../../home/programs/qutebrowser
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/spicetify
    ../../home/programs/nextcloud
    ../../home/programs/yazi
    ../../home/programs/markdown

    # Scripts
    ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/hypridle
    ../../home/system/hyprlock
    ../../home/system/hyprpanel
    ../../home/system/hyprpaper
    ../../home/system/gtk
    ../../home/system/wofi
    ../../home/system/batsignal
    ../../home/system/zathura
    ../../home/system/mime
    ../../home/system/udiskie
    ../../home/system/clipman

    ./secrets # You should probably remove this line
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      discord
      xfce.thunar
      bitwarden
      vlc

      # Dev
      go
      nodejs
      python3
      jq
      figlet

      # Utils
      zip
      unzip
      optipng
      pfetch
      pandoc
      btop

      # Just cool
      peaclock
      cbonsai
      pipes
      cmatrix
      cava

      # Backup
      vscode
      firefox
      neovide
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".profile_picture.png" = { source = ./profile_picture.png; };

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

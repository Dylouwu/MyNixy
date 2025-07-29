{ pkgs, config, ... }: {

  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/kitty
    ../../home/programs/nvim
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/thunar
    ../../home/programs/lazygit
    ../../home/programs/zen
    ../../home/programs/tailscale
    ../../home/programs/zellij

    # scripts
    ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/hyprlock
    #../../home/system/hyprpanel # CHANGEME: Enable this if you want to use hyprpanel (and comment waybar)
    ../../home/system/waybar
    ../../home/system/hyprpaper
    ../../home/system/wofi
    ../../home/system/zathura
    ../../home/system/mime
    ../../home/system/udiskie
    ../../home/system/clipman

    ./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Apps
      bitwarden # Password manager
      discord
      vlc # Video player
      curtail # Compress images
      obsidian # Markdown editor
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

      # Utils
      file
      zip
      unzip
      btop
      pavucontrol
      fastfetch
      veracrypt

      # Backup
      firefox
      vscode
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

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
    ../../home/system/hypridle
    ../../home/system/hyprlock
    ../../home/system/hyprpanel
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
      vscode
      resources
      obsidian # Markdown editor
      # gnome-text-editor # Text editor

      # Dev
      clang
      libcxx
      go
      air
      nodejs
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
      fastfetch
      veracrypt

      # Backup browser
      firefox
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = { source = ../../src/purin.jpg; };

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

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
    ../../home/programs/nextcloud
    ../../home/programs/thunar
    ../../home/programs/lazygit
    ../../home/programs/zen
    ../../home/programs/discord
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
      vlc # Video player
      curtail # Compress images
      vscode
      modrinth-app
      everest-mons
      osu-lazer-bin
      resources
      # blanket # White-noise app
      obsidian # Note taking app
      # planify # Todolists
      # textpieces # Manipulate texts

      # Dev
      clang
      libcxx
      go
      nodejs
      jq
      just
      pnpm
      zulu

      # Utils
      zip
      unzip
      btop
      fastfetch

      # Backup
      # firefox
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = { source = ./purin.jpg; };

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

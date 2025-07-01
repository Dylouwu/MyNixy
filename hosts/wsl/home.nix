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
    ../../home/programs/lazygit
    ../../home/programs/tailscale
    ../../home/programs/zellij

    # scripts
    ../../home/scripts # All scripts

    ./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
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
    ];

    # Import my profile picture, used by the hyprpanel dashboard
    file.".face.icon" = { source = ../../src/purin.jpg; };

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

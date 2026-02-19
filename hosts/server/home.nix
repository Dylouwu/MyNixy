{ pkgs, config, ... }: {

  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/nvim
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/lazygit
    ../../home/programs/zellij

    # Scripts
    ../../home/scripts/nixy # Only nixy script
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Dev
      clang
      libcxx
      go
      python3
      jq
      just
      pnpm

      # Utils
      file
      zip
      unzip
      btop
      fastfetch
      tailscale
    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

{ pkgs, config, ... }: {

  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    ../../home/programs/nvim
    ../../home/programs/shell
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/git/signature.nix
    ../../home/programs/lazygit
    ../../home/programs/zellij

    # Scripts
    ../../home/scripts # All scripts
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      # Dev
      clang
      libcxx
      go
      nodejs
      python3
      jq
      just
      pnpm

      # Utils
      zip
      unzip
      btop
      fastfetch
      tailscale
      wireguard-tools

    ];

    # Don't touch this
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}

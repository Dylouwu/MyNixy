{ config, ... }: {
  imports = [
    # Mostly system related configuration
    ../../nixos/nvidia.nix # CHANGEME: Remove this line if you don't have an Nvidia GPU
    ../../nixos/audio.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/grub.nix
    # ../../nixos/tuigreet.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    # ../../nixos/docker.nix
    ../../nixos/sddm.nix
    ../../nixos/steam.nix
    ../../nixos/tailscale.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  stylix.targets.grub.enable = false;
  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}

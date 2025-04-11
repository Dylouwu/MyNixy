{ config, ... }: {
  imports = [
    # Mostly system related configuration
    ../../nixos/audio.nix
    ../../nixos/docker.nix
    ../../nixos/fonts.nix
    ../../nixos/grub.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/nvidia.nix
    ../../nixos/sddm.nix
    ../../nixos/steam.nix
    ../../nixos/tailscale.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  stylix.targets.grub.enable = false;
  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}

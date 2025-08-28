{ config, ... }: {
  imports = [
    # Mostly system related configuration
    ../../nixos/audio.nix
    ../../nixos/docker.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/hyprland.nix
    ../../nixos/nix.nix
    ../../nixos/nvidia.nix # CHANGEME : remove this line if you don't have an Nvidia GPU
    ../../nixos/sddm.nix
    ../../nixos/steam.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/tailscale.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/xserver.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  stylix.targets.grub.enable = false;
  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}

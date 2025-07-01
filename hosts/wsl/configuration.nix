{ config, ... }: {
  imports = [
    # Mostly system related configuration
    ../../nixos/docker.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
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
  
  wsl = {
    enable = true; # Enable WSL support
    defaultUser = config.var.username; # Set the default user for wsl
  };

  # Don't touch this
  system.stateVersion = "24.05";
}

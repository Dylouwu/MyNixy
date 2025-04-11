{ config, ... }: {
  imports = [
    ../../nixos/home-manager.nix
    ../../nixos/nix.nix
    ../../nixos/systemd-boot.nix
    ../../nixos/tailscale.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix

    ../../server-modules/adguardhome.nix
    ../../server-modules/bitwarden.nix
    ../../server-modules/cloudflare.nix
    ../../server-modules/cyberchef.nix
    ../../server-modules/fail2ban.nix
    ../../server-modules/firewall.nix
    ../../server-modules/glance.nix
    ../../server-modules/mealie.nix
    ../../server-modules/meilisearch.nix
    ../../server-modules/minecraft.nix
    ../../server-modules/nextcloud.nix
    ../../server-modules/nginx.nix
    ../../server-modules/ssh.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix

    ./secrets
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "24.05";
}

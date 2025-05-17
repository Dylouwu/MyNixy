{ config, pkgs, ... }:
let username = config.var.username;
in {
  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      sshconfig = {
        owner = "${username}";
        path = "/home/${username}/.ssh/config";
        mode = "0600";
      };
      github-key = {
        owner = "${username}";
        path = "/home/${username}/.ssh/github";
        mode = "0600";
      };
      cloudflare-dns-token = { path = "/etc/cloudflare/dnskey.txt"; };
      nextcloud-pwd = { path = "/etc/nextcloud/pwd.txt"; };
      adguard-pwd = { mode = "0777"; };
      tailscale-api-key = { mode = "0777"; };
      minecraft-api-key = {
        owner = "minecraft";
        path = "/etc/minecraft/api-key.txt";
        mode = "0600";
      };
      signing-key = {
        owner = "${username}";
        path = "/home/${username}/.ssh/signing-key";
        mode = "0600";
      };
      signing-key-pub = {
        owner = "${username}";
        path = "/home/${username}/.ssh/signing-key.pub";
        mode = "0600";
      };
      glance-api-key = { mode = "0777"; };
      github-token = { path = "/home/${username}/.config/nix/nix.conf"; };
      # hoarder = { };
      # recyclarr = {
      #   owner = "recyclarr";
      #   mode = "0777";
      # };
      # wireguard-pia = { };
    };
  };

  environment.systemPackages = with pkgs; [ sops age ];
}

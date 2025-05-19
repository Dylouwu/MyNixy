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
      };
      github-key = {
        owner = "${username}";
        path = "/home/${username}/.ssh/github";
      };
      cloudflare-dns-token = {
        path = "/etc/cloudflare/dnskey.txt";
      };
      nextcloud-pwd = {
        owner = "nextcloud";
        path = "/etc/nextcloud/pwd.txt";
      };
      adguard-pwd = { owner = "glance"; };
      tailscale-api-key = { owner = "glance"; };
      minecraft-api-key = {
        owner = "minecraft";
        path = "/etc/minecraft/api-key.txt";
      };
      signing-key = {
        owner = "${username}";
        path = "/home/${username}/.ssh/signing-key";
      };
      signing-key-pub = {
        owner = "${username}";
        path = "/home/${username}/.ssh/signing-key.pub";
      };
      glance-api-key = { owner = "glance"; };
      github-token = {
        owner = "${username}";
        path = "/home/${username}/.config/nix/nix.conf";
      };
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

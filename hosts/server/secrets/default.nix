{ pkgs, ... }: {
  sops = {
    age.keyFile = "/home/dilounix/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      sshconfig = {
        owner = "dilounix";
        path = "/home/dilounix/.ssh/config";
        mode = "0600";
      };
      github-key = {
        owner = "dilounix";
        path = "/home/dilounix/.ssh/github";
        mode = "0600";
      };
      cloudflare-dns-token = { path = "/etc/cloudflare/dnskey.txt"; };
      nextcloud-pwd = { path = "/etc/nextcloud/pwd.txt"; };
      adguard-pwd = { };
      tailscale-api-key = { };
      minecraft-api-key = {
        path = "/etc/minecraft/api-key.txt";
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

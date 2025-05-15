{ config, pkgs, inputs, ... }:
let username = config.var.username;
in {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      ssh-config = { path = "/home/${username}/.ssh/config"; };
      github-key = { path = "/home/${username}/.ssh/github"; };
      weather-key = { path = "/home/${username}/.weather.json"; };
      github-token = { path = "/home/${username}/.config/nix/nix.conf"; };
      signing-key = { path = "/home/${username}/.ssh/signing-key"; };
      signing-key-pub = { path = "/home/${username}/.ssh/signing-key.pub"; };
      #gitlab-key = { path = "/home/${username}/.ssh/gitlab"; };
      #pia = { path = "/home/${username}/.config/pia/pia.ovpn"; };

    };
  };

  home.file.".config/nixos/.sops.yaml".text = ''
    keys:
      - &primary age187l3764s2kd49mn6tmagjgmke0t5ak2lgwqnhxayfjt7dqu8ycesa68u73
    creation_rules:
      - path_regex: hosts/laptop/secrets/secrets.yaml$
        key_groups:
          - age:
            - *primary
      - path_regex: hosts/server/secrets/secrets.yaml$
        key_groups:
          - age:
            - *primary
  '';

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  home.packages = with pkgs; [ sops age ];

  wayland.windowManager.hyprland.settings.exec-once =
    [ "systemctl --user start sops-nix" ];
}

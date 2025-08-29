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
      hyrule-key = { path = "/home/${username}/.ssh/hyrule"; };
      weather-key = { path = "/home/${username}/.weather.json"; };
      github-token = { path = "/home/${username}/.config/nix/nix.conf"; };
      signing-key = { path = "/home/${username}/.ssh/signing-key"; };
      signing-key-pub = { path = "/home/${username}/.ssh/signing-key.pub"; };

    };
  };

  home.file.".config/nixos/.sops.yaml".text = ''
    keys:
      - &primary age1sczt9uyv34veyv6lz74x3u84w0x0f2c6j4k95xgh8ruvfx77mfjsx79wum
    creation_rules:
      - path_regex: hosts/laptop/secrets/secrets.yaml$
        key_groups:
          - age:
            - *primary
  '';

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  home.packages = with pkgs; [ sops age ];

  wayland.windowManager.hyprland.settings.exec-once =
    [ "systemctl --user start sops-nix" ];
}

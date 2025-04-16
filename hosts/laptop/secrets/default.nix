{ pkgs, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "/home/dilounix/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      ssh-config = { path = "/home/dilounix/.ssh/config"; };
      github-key = { path = "/home/dilounix/.ssh/github"; };
      weather-key = { path = "/home/dilounix/.weather.json"; };
      github-rate = { path = "/home/dilounix/.config/nix/nix.conf"; };
      #gitlab-key = { path = "/home/dilounix/.ssh/gitlab"; };
      #jack-key = { path = "/home/dilounix/.ssh/jack"; };
      #pia = { path = "/home/dilounix/.config/pia/pia.ovpn"; };

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

{
  # https://github.com/anotherhadi/nixy
  description = ''
    Nixy is a NixOS configuration with home-manager, secrets and custom theming all in one place.
    It's a simple way to manage your system configuration and dotfiles.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    stylix.url = "github:danth/stylix";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    zen-browser.url =
      "github:0xc000022070/zen-browser-flake/3c4f98e9504d3f94bbd303d428162665a0ade8d6";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    glance-minecraft-power.url = "github:Dylouwu/glance-minecraft-power";
    minecraft-datapacks = {
      url = "github:Dylouwu/minecraft-datapacks";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {
      # This is my laptop configuration
      nixy = nixpkgs.lib.nixosSystem {
        modules = [
          { _module.args = { inherit inputs; }; }
          inputs.nixos-hardware.nixosModules.omen-16-n0005ne # CHANGEME: check https://github.com/NixOS/nixos-hardware
          inputs.home-manager.nixosModules.home-manager
          inputs.minegrub-world-sel-theme.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.sops-nix.nixosModules.sops
          ./hosts/laptop/configuration.nix # CHANGEME: change the path to match your host folder
        ];
      };
      # This is my server configuration
      hyrule = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { _module.args = { inherit inputs; }; }
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.sops-nix.nixosModules.sops
          inputs.glance-minecraft-power.nixosModules.glance-minecraft-power
          ./hosts/server/configuration.nix # CHANGEME: change the path to match your host folder
        ];
      };
      # This is for my old laptop
      old_nixy = nixpkgs.lib.nixosSystem {
        modules = [
          { _module.args = { inherit inputs; }; }
          inputs.home-manager.nixosModules.home-manager
          inputs.minegrub-world-sel-theme.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.sops-nix.nixosModules.sops
          ./hosts/old_laptop/configuration.nix # CHANGEME: change the path to match your host folder
        ];
      };
      # This is for my wsl config
      wsl = nixpkgs.lib.nixosSystem {
        modules = [
          { _module.args = { inherit inputs; }; }
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.sops-nix.nixosModules.sops
          inputs.nixos-wsl.nixosModules.default
          ./hosts/wsl/configuration.nix # CHANGEME: change the path to match your host folder
        ];
      };

    };
  };
}

{ config, pkgs, lib, inputs, ... }:
let domain = "mc.dilou.me";
in {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
}

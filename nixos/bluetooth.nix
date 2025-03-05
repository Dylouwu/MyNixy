{ pkgs, ... }: {
  # environment.systemPackages = with pkgs; [ blueman ];
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
  };
  # services.blueman.enable = true;
}

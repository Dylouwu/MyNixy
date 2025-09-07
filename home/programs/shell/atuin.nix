{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      sync_address = "https://atuin.dilou.me";
      sync_frequency = "10m";
      update_check = false;
      dialect = "uk";
      invert = true;
      style = "full";
    };
  };
}

{
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ 80 443 25565 ];
    allowedUDPPorts = [ 80 443 ];
  };
}

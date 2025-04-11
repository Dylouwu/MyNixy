{
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 80 443 ];
  };
}

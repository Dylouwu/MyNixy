{ config, ... }: {
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      AllowUsers = [ config.var.username ];
    };
  };

  users.users."${config.var.username}" = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBF4SKCHAyjQddBkTJhtK36ENayvsPKMmiALCAxzX6D dilounix@nixy"
    ];
  };
}

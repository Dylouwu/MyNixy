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
    openssh.authorizedKeys.keys =
      [ # CHANGEME: Add your public keys here and remove the example ones
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMgvCqXwaF87hlxldb+7JZaw26WM3lKzOFPE5orTZUD2 dilounix@nixy"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs80tggMfcG0dnnTMy/v0dPzEzM9jfntMlfkZrtmtjwz6+xWspDOd09hxGgpbBip7nh81nRK0HL/YDj8ycwq4Nq4ODyKmKjXXaNfWB32GEFSXoDdrMH1Oya00x6KoWH7AkHD/vE1hxcj2yLvCy3FkExGuL1pVGfTHTOvjj9VioJdcWcstsw7lSDXJ5ZzkujlpmLsRy53bwaPAeQXT9wfwTdfGmDnVsQtMthK8/eG7GSuIgJeiMx6pJpyYZmTxZapBlF7KPGQvg9nb4Aagc4ShjOFbdNowyVtfqSMy4dl3GFnVRE3r4PnVsq+c0E0v+OrwAnTnujtQbEYgL4OowSh0C/2XwvNgJvZvBhLd8EqURAF1UtNJzvGlpwa5iKwH183a85F8fu2pJmx39qwytqv0QozB2WrHR85pi5341j3C3NK8LNVAwvGheNmnC0OrVYjdYYljLNjGw1HO1fTyEGw3X2ypAHyrkR+89WtC0MN6C9L03FZqO0v/mMNifEwTV2Rk= dilou@PC_de_dilou"
      ];
  };
}

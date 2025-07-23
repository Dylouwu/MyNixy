{ pkgs, inputs, ... }: {

  fonts = {
    packages = with pkgs; [
      roboto
      work-sans
      comic-neue
      source-sans
      comfortaa
      inter
      lato
      lexend
      jost
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
      openmoji-color
      twemoji-color-font
      inputs.cartographcf.packages.${pkgs.system}.default
    ];

    enableDefaultPackages = false;
  };
}

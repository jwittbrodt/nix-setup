{ config, pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Lilex Nerd Font" ];
    };
  };
  home.packages = with pkgs.nerd-fonts; [
    lilex
  ];
}

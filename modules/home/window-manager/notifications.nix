{ config, lib, ... }:

{
  services.mako = {
    enable = true;
    settings = with config.scheme.withHashtag; {
      anchor = "top-right";
      background-color = base01;
      border-color = base05;
      border-radius = 0;
      font = "${lib.head config.fonts.fontconfig.defaultFonts.monospace} 10";
      height = 2000;
      icons = true;
      markup = true;
      width = 400;
    };
  };
}

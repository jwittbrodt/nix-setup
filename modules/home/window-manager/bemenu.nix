{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.bemenu = {
    enable = true;
    settings = with config.scheme.withHashtag; {
      line-height = 29;
      prompt = "▶";
      ignorecase = true;
      fn = lib.head config.fonts.fontconfig.defaultFonts.monospace;
      fb = base01;
      nb = base01;
      tb = base01;
      hb = base01;
      tf = blue;
      hf = blue;
      ff = base05;
      nf = base05;
      af = base05;
      ab = base00;
    };
  };
}

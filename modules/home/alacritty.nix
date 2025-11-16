{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      colors =
        with config.scheme.withHashtag;
        let
          default = {
            black = base00;
            white = base07;
            inherit
              red
              green
              yellow
              blue
              cyan
              magenta
              ;
          };
        in
        {
          primary = {
            background = base00;
            foreground = base05;
          };
          cursor = {
            text = base02;
            cursor = base07;
          };
          normal = default;
          bright = default;
          dim = default;
        };
      font = {
        size = 13;
        normal.family = lib.head config.fonts.fontconfig.defaultFonts.monospace;
      };
      keyboard.bindings = [
        {
          action = "Copy";
          key = "C";
          mods = "Control|Alt";
        }
        {
          action = "Paste";
          key = "V";
          mods = "Control|Alt";
        }
      ];
      window = {
        decorations = "none";
        opacity = 0.9;
        dimensions = {
          columns = 0;
          lines = 0;
        };
      };
      general.live_config_reload = true;
    };
  };
}

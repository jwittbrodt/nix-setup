{ config, pkgs, lib, nix-colors, ... }:

{
  programs.alacritty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.alacritty;
    settings = {
      colors = {
        primary = {
          background = "0x${config.colorScheme.palette.base00}";
          foreground = "0x${config.colorScheme.palette.base05}";
        };
        normal = {
          black = "0x${config.colorScheme.palette.base00}";
          blue = "0x${config.colorScheme.palette.base0D}";
          cyan = "0x${config.colorScheme.palette.base0C}";
          green = "0x${config.colorScheme.palette.base0B}";
          magenta = "0x${config.colorScheme.palette.base0E}";
          red = "0x${config.colorScheme.palette.base08}";
          white = "0x${config.colorScheme.palette.base05}";
          yellow = "0x${config.colorScheme.palette.base0A}";
        };
        bright = {
          black = "0x${config.colorScheme.palette.base03}";
          blue = "0x${config.colorScheme.palette.base0D}";
          cyan = "0x${config.colorScheme.palette.base0C}";
          green = "0x${config.colorScheme.palette.base0B}";
          magenta = "0x${config.colorScheme.palette.base0E}";
          red = "0x${config.colorScheme.palette.base08}";
          white = "0x${config.colorScheme.palette.base07}";
          yellow = "0x${config.colorScheme.palette.base0A}";
        };
        draw_bold_text_with_bright_colors = true;
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

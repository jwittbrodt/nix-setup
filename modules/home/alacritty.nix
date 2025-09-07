{ config, pkgs, nix-colors, ... }:

{
  programs.alacritty = {
    enable = true;
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
    };
  };
}

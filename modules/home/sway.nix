{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    package = null; # TODO: try enabling with nixgl
    config = {
      modifier = "Mod4";
      terminal = "alacritty";

      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
        border = 1;
      };

      gaps = {
        smartGaps = true;
        smartBorders = "on";
      };

      colors = with config.scheme.withHashtag; rec {
        background = base00;
        focused = {
          border = base03;
          background = background;
          text = blue;
          indicator = background;
          childBorder = background;
        };
        unfocused = focused // { text = focused.border; };
        focusedInactive = focused // { text = background; };
        placeholder = focused // { text = base05; };
        urgent = {
          border = focused.border;
          background = red;
          text = background;
          indicator = red;
          childBorder = red;
        };
      };

      input = {
        "2:7:SynPS/2_Synaptics_TouchPad" = {
          tap = "enabled";
          accel_profile = "adaptive";
          pointer_accel = "0.15";
          dwt = "enabled";
        };
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "us";
          xkb_variant = "euro";
          xkb_options = "compose:caps,shift:both_capslock";
        };
      };

      output = {
        "eDP-1" = {
          scale = "1.0";
        };
      };

      # TODO: idle
      # TODO: bemenu
      # TODO: font
      # TODO: workspace icons
      # TODO: fn keys
      # TODO: bar
      # TODO: for_window
      # TODO: assignments/autostart
    };
  };
}

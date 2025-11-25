{
  config,
  pkgs,
  lib,
  ...
}:

{
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";

      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
        border = 1;
      };

      floating = {
        border = 1;
        titlebar = true;
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
        unfocused = focused // {
          text = focused.border;
        };
        focusedInactive = focused // {
          text = background;
        };
        placeholder = focused // {
          text = base05;
        };
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

      fonts = {
        names = config.fonts.fontconfig.defaultFonts.monospace;
        style = "Regular";
        size = 12.0;
      };

      bars = [
        {
          fonts = fonts;
          position = "top";
          workspaceNumbers = false;
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs config-default.toml";
          colors = with config.scheme.withHashtag; rec {
            background = base00;
            focusedWorkspace = {
              border = blue;
              background = background;
              text = base05;
            };
            activeWorkspace = {
              border = background;
              background = background;
              text = base05;
            };
            inactiveWorkspace = {
              border = background;
              background = background;
              text = base03;
            };
            urgentWorkspace = {
              border = background;
              background = red;
              text = background;
            };
            bindingMode = {
              border = background;
              background = red;
              text = background;
            };
          };
          extraConfig = "height 29";
        }
      ];

      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
      };
    };
  };
}

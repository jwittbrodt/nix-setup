{ config, pkgs, lib, ... }:

{
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = rec {
        settings = {
          theme = {
            theme = theme;
            overrides = with config.scheme.withHashtag; {
              separator = "<span rise='-22000' font='15'></span>";
              idle_bg = base00;
              idle_fg = base05;
              info_bg = cyan;
              info_fg = base00;
              good_bg = green;
              good_fg = base00;
              warning_bg = yellow;
              warning_fg = base00;
              critical_bg = red;
              critical_fg = base00;
            };
          };
        };
        icons = "material-nf";
        theme = "modern";
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            warning = 20.0;
            alert = 10.0;
            format = "$icon $available.eng(range:..30e9) |";
          }
          {
            block = "memory";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "temperature";
          }
          {
            block = "net";
            format = " $icon  ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) ";
          }
          {
            block = "battery";
          }
          { block = "sound"; }
          {
            block = "time";
            interval = 60;
          }
        ];

      };
    };
  };
}

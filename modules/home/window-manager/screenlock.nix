{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.swaylock = {
    enable = true;
    package = null; # TODO: see https://github.com/NixOS/nixpkgs/issues/158025
    settings = with config.scheme; {
      daemonize = true;
      color = base00;
      inside-color = base00;
      line-uses-ring = true;
      ring-color = blue;
      key-hl-color = yellow;
      bs-hl-color = red;
      ring-wrong-color = red;
      inside-wrong-color = red;
      ring-ver-color = yellow;
      inside-ver-color = yellow;
      ring-clear-color = base00;
      inside-clear-color = blue;
      separator-color = blue;
      font = lib.head config.fonts.fontconfig.defaultFonts.monospace;
    };
  };
  services.swayidle = {
    enable = true;
    events = {
      "before-sleep" =
        "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ 1; ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ 1; /usr/bin/swaylock";
    };
    timeouts = [
      {
        timeout = 120;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      {
        timeout = 300;
        command = "/usr/bin/swaylock";
      }
    ];
  };
  wayland.windowManager.sway.config.window.commands = [
    {
      command = "inhibit_idle fullscreen";
      criteria = {
        app_id = "firefox";
      };
    }
  ];
}

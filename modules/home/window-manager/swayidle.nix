{ config, pkgs, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ 1; ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ 1; /usr/bin/swaylock";
      }
      {
        event = "after-resume";
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
    timeouts = [
      {
        timeout = 120;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
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

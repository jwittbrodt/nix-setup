{ pkgs, ... }:

{
  imports = [
    ./bemenu.nix
    ./i3status-rust.nix
    ./notifications.nix
    ./screenlock.nix
    ./sway.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    pulseaudio
    brightnessctl
  ];

  programs.zsh.loginExtra = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';
}

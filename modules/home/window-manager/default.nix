{ pkgs, ... }:

{
  imports = [
    ./bemenu.nix
    ./i3status-rust.nix
    ./screenlock.nix
    ./sway.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    pulseaudio
  ];
}

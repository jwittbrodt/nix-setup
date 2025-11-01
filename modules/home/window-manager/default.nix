{ pkgs, ... }:

{
  imports = [
    ./bemenu.nix
    ./i3status-rust.nix
    ./sway.nix
    ./swayidle.nix
    ./swaylock.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
  ];
}

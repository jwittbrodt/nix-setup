{ config, pkgs, nix-colors, ... }:

{
  imports = [
    ./alacritty.nix
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.eighties;

  home.username = "jonasw";
  home.homeDirectory = "/home/jonasw";

  programs.home-manager.enable = true;

  home.stateVersion = "25.05"; # Please read the comment before changing.
}

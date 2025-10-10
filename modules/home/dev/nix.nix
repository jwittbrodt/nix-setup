{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style
    direnv
    nix-direnv
  ];
}

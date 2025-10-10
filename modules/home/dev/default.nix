{ pkgs, config, ... }:

{
  imports = [
    ./nix.nix
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}

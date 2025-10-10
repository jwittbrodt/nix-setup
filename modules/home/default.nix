{
  config,
  pkgs,
  nixgl,
  base16,
  tt-schemes,
  ...
}:

{
  imports = [
    ./alacritty.nix
    ./dev
    ./fonts.nix
    ./git.nix
    ./ssh-client.nix
    ./window-manager
    base16.homeManagerModule
  ];

  scheme = "${tt-schemes}/base16/eighties.yaml";

  home.username = "jonasw";
  home.homeDirectory = "/home/jonasw";

  nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.05"; # Please read the comment before changing.
}

{
  base16,
  tt-schemes,
  ...
}:

rec {
  imports = [
    ./alacritty.nix
    ./dev
    ./fonts.nix
    ./git.nix
    ./music.nix
    ./ssh-client.nix
    ./window-manager
    ./zsh.nix
    base16.homeManagerModule
  ];

  scheme = "${tt-schemes}/base16/eighties.yaml";

  home.username = "jonasw";
  home.homeDirectory = "/home/jonasw";

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
    nixGL.packages = null;
  };

  sops.age.keyFile = "${home.homeDirectory}/.age/key.txt";

  programs.home-manager.enable = true;

  home.stateVersion = "25.05"; # Please read the comment before changing.
}

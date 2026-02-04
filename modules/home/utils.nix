{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    graphicsmagick
  ];
}

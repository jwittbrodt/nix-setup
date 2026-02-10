{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    graphicsmagick
    jq
    yq
  ];
}

{
  pkgs,
  config,
  ...
}:

{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config.common = {
      default = [
        "wlr"
        "gtk"
      ];
    };
  };
  # workaround until https://github.com/nix-community/home-manager/pull/8541 is merged
  systemd.user.packages = [ pkgs.xdg-desktop-portal ] ++ config.xdg.portal.extraPortals;
}

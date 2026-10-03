{ ... }:

{
  imports = [
    ../modules/home
  ];

  home.username = "jonas.wittbrodt";

  my.isWork = true;

  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "595.91.07";
    sha256 = "sha256-yiPIjdJLB6GRZE4eEc+3vN11NzBXSa9A+YABiwleYxM=";
  };
}

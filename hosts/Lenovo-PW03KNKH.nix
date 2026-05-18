{ ... }:

{
  imports = [
    ../modules/home
  ];

  home.username = "jonas.wittbrodt";

  my.isWork = true;

  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "580.142";
    sha256 = "sha256-IJFfzz/+icNVDPk7YKBKKFRTFQ2S4kaOGRGkNiBEdWM=";
  };
}

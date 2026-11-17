{ ... }:

{
  imports = [
    ../modules/home
  ];

  home.username = "jonas.wittbrodt";

  my.isWork = true;

  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "595.99.02";
    sha256 = "sha256-6HR3lYv3YwcFSTJL1a1slI66btIQ5EAFs+/4SUD24ew=";
  };
}

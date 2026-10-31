{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    awscli2
    # azure-cli ## currently broken python-fabric dependency
    google-cloud-sdk
  ];
}

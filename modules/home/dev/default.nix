{ pkgs, config, ... }:

{
  imports = [
    ./nix.nix
    ./vscode.nix
  ];
}

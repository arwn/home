{ config, pkgs, shared, ... }:

{
  imports = [ ./shared.nix ];

  home.username = "arwn";
  home.homeDirectory = "/Users/arwn";

  home.packages = [
    pkgs.colima
    pkgs.docker
  ];
}

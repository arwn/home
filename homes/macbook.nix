{ config, pkgs, shared, ... }:

{
  imports = [ ./shared.nix ];

  home.username = "arwn";
  home.homeDirectory = "/Users/arwn";
}

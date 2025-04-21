{ config, pkgs, shared, ... }:

{
  imports = [ ./shared.nix ];

  home.username = "aren.windham";
  home.homeDirectory = "/Users/aren.windham";
}

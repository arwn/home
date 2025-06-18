{ config, pkgs, shared, ... }:

{
  imports = [ ./shared.nix ];

  home.username = "aren.windham";
  home.homeDirectory = "/Users/aren.windham";

  programs.fish.shellInit = ''
    set -gx TELEPORT_PROXY transporter.ic-ops.com:443
    set -gx TELEPORT_CLUSTER transporter.ic-ops.com
    set -gx TELEPORT_USER aren.windham@immuta.com
  '';
}

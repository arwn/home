{ config, pkgs, lib, ... }:

{
  imports = [ ./shared.nix ];

  home.username = "aren.windham";
  home.homeDirectory = "/Users/aren.windham";

  home.packages = lib.mkAfter [
    # pkgs.mise
  ];

  programs.fish.shellInit = ''
    set -gx NX_TUI false

    set -U fish_user_paths $fish_user_paths /Users/aren.windham/.local/bin
    
    set -gx TELEPORT_PROXY transporter.ic-ops.com:443
    set -gx TELEPORT_CLUSTER transporter.ic-ops.com
    set -gx TELEPORT_USER aren.windham@immuta.com
    set -gx MISE_ENV development
    set -gx MISE_SHELL fish
    set -gx __MISE_ORIG_PATH $PATH

    # native tests
    set -gx VAULT_ADDR https://vault.infrastructure.immuta.io:8200
    
    set -gx PATH /Users/aren.windham/.local/bin /Users/aren.windham/.nix-profile/bin /nix/var/nix/profiles/default/bin /usr/local/bin /System/Cryptexes/App/usr/bin /usr/bin /bin /usr/sbin /sbin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin '/Applications/VMware Fusion.app/Contents/Public' /usr/local/munki /Applications/iTerm.app/Contents/Resources/utilities
   
    /Users/aren.windham/.local/bin/mise activate fish | source
  '';
}

{ config, pkgs, shared, ... }:

{
  imports = [ ./shared.nix ];

  home.username = "a";
  home.homeDirectory = "/home/a";

  home.packages = [
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv = {
      enable = true;
    };
    # direnv 2.37.1's bash test suite hangs on darwin because some
    # test scenarios contain literal backspace/CR characters in
    # directory names which trip up macOS filesystem ops. Skip the
    # check phase on darwin until upstream fixes this.
    package = pkgs.direnv.overrideAttrs (old: {
      doCheck = false;
    });
  };
}

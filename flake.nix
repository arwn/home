{
  description = "Home Manager configuration of aren.windham";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jujutsu.url = "github:martinvonz/jj";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      macSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";
      pkgsMac = nixpkgs.legacyPackages.${macSystem};
      pkgsMacWork = import nixpkgs {
        system = macSystem;
        config.allowUnfreePredicate = pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [ "acli" ];
      };
      pkgsLinux = nixpkgs.legacyPackages.${linuxSystem};
    in {
      homeConfigurations."arwn" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsMac;
        modules = [ ./homes/macbook.nix ];
      };

      homeConfigurations."aren.windham" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsMacWork;
        modules = [ ./homes/macbook-work.nix ];
      };

      homeConfigurations."a" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsLinux;
        modules = [ ./homes/linux-a.nix ];
      };
    };
}

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
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."arwn" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./homes/macbook.nix ];
      };

      homeConfigurations."aren.windham" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./homes/macbook-work.nix ];
      };
    };
}

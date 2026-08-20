{
  description = "Home Manager configuration of aren.windham";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }: {
    homeConfigurations."arwn" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [ ./homes/macbook.nix nixvim.homeModules.nixvim ];
    };

    homeConfigurations."aren.windham" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      modules = [ ./homes/macbook-work.nix nixvim.homeModules.nixvim ];
    };

    homeConfigurations."a" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./homes/linux-a.nix nixvim.homeModules.nixvim ];
    };
  };
}

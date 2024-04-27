{
  description = "RicOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.zenblade = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/zenblade/configuration.nix

	      home-manager.nixosModules.home-manager {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;

	        home-manager.users.rico = import ./home/home.nix;
	      }
      ];
    };
  };
}

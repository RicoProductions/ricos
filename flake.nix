{
  description = "RicOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    openrgb-experimental = {
      url = "gitlab:CalcProgrammer1/OpenRGB";
      flake = false;
    };

    looking-glass-experimental = {
      url = "git+https://github.com/gnif/LookingGlass?submodules=1";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations =
    let
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts
        ./modules
      ];
    in {

      silverlight = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs // {
          hostname = "silverlight";
          username = "rico";
        };
        modules = modules;
      };

      zenblade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs // {
          hostname = "zenblade";
          username = "rico";
        };
        modules = modules;
      };

      minix-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs // {
          hostname = "minix-server";
          username = "nix-host";
        };
        modules = modules;
      };

      live-image = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs // {
          hostname = "live-image";
          username = "nixos";
        };
        modules = modules;
      };
    };
  };
}

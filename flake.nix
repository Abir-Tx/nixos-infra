{
  description = "Abir's NixOS infrastructure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

        home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      kvm-workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";


        modules = [
          ./hosts/kvm-workstation/configuration.nix

	  home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abir = import ./home/abir/home.nix;
          }
        ];
      };
    };
  };
}


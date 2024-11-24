{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-dotnet.url = "github:nixos/nixpkgs/6113a9f660144427e7e79e868825611384a2f852";

    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # m8c = {
    #   url = "https://github.com/laamaa/m8c/archive/refs/heads/main.tar.gz"
    # }

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-dotnet, home-manager, ...  } @ inputs:
    let
      inherit (self) outputs;
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
      pkgs-dotnet = import nixpkgs-dotnet {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
      colors = import ./home/common/colors.nix {};
    in {
      nixosConfigurations = {
        valus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs pkgs-unstable pkgs-dotnet colors; };
          modules = [
            ./hosts/valus/configuration.nix
          ];
        };
        avion = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs pkgs-unstable pkgs-dotnet colors; };
          modules = [
            ./hosts/valus/configuration.nix
          ];
        };
      };
    };
}

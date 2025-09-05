{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware?rev=3c5e12673265dfb0de3d9121420c0c2153bf21e0";

    nixpkgs-dotnet.url = "github:nixos/nixpkgs/?rev=5f71945ecb996631a194890b16162e58a1f5e65f";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixpkgs-dotnet, ...  } @ inputs:
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
            ./hosts/avion/configuration.nix
          ];
        };
        hydrus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs pkgs-unstable; };
          modules = [
            ./hosts/hydrus/configuration.nix
          ];
        };
      };
    };
}

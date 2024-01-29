{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    solaar = {
      url = "github:Svenum/Solaar-Flake/latest"; # For latest stable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # m8c = {
    #   url = "https://github.com/laamaa/m8c/archive/refs/heads/main.tar.gz"
    # }

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-colors, solaar, ...  } @ inputs:
    let
      inherit (self) outputs;
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        valus = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs pkgs-unstable nix-colors; };
          modules = [
            solaar.nixosModules.default
            ./hosts/valus/configuration.nix
          ];
        };
      };
    };
}

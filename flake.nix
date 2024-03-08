{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { nixpkgs, home-manager, spicetify-nix, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ nur.overlay ];
      };
      lib = nixpkgs;
      in
    {
      nixosConfigurations = {
        scorpia = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./scorpia/configuration.nix
          ];
        };
        montana = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./montana/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        pingu = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
          };
          modules = [
            nur.hmModules.nur
            ./home.nix
          ];
        };
      };
    };
}

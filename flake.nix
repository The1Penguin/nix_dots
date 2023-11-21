{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { nixpkgs, home-manager, spicetify-nix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      lib = nixpkgs;
    in
    {
      nixosConfigurations = {
        scorpia = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        pingu = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit spicetify-nix; };
          modules = [
            ./home.nix
          ];
        };
      };
    };
}

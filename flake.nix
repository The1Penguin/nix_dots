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
    any-nix-shell = {
      url = "github:The1Penguin/any-nix-shell/nix_develop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, spicetify-nix, nur, any-nix-shell, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          nur.overlay
        ];
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
        entrapta = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./entrapta/configuration.nix
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
        "scorpia" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
            inherit any-nix-shell;
            desktop = false;
            laptop = true;
          };
          modules = [
            nur.hmModules.nur
            ./home.nix
          ];
        };
        "entrapta" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
            inherit any-nix-shell;
            desktop = true;
            laptop = false;
          };
          modules = [
            nur.hmModules.nur
            ./home.nix
          ];
        };
        "montana" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
            inherit any-nix-shell;
            desktop = false;
            laptop = true;
          };
          modules = [
            nur.hmModules.nur
            ./home.nix
          ];
        };
      };
    };
}

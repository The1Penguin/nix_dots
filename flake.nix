{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-2405.url = "github:nixos/nixpkgs/nixos-24.05";
    lix = {
      url = "git+https://git.lix.systems/lix-project/lix?ref=refs/tags/2.90.0-rc1";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.lix.follows = "lix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

  outputs = { nixpkgs, nixpkgs-2405, lix-module, home-manager, spicetify-nix, nur, any-nix-shell, ... }:
    let
      system = "x86_64-linux";
      overlay-2405 = final: prev: {
        stable = import nixpkgs-2405 {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          nur.overlay
          overlay-2405
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
            lix-module.nixosModules.default
          ];
        };
        entrapta = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./entrapta/configuration.nix
            lix-module.nixosModules.default
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
            lix-module.nixosModules.default
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
            lix-module.nixosModules.default
          ];
        };
      };
    };
}

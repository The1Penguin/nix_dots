{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-2411.url = "github:nixos/nixpkgs/nixos-24.11";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    any-nix-shell = {
      url = "github:The1Penguin/any-nix-shell/nix_develop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvidia-patch = {
      url = "github:icewind1991/nvidia-patch-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
  };

  outputs = { nixpkgs, nixpkgs-2411, lix-module, home-manager, spicetify-nix, nur, any-nix-shell, catppuccin, nixos-xivlauncher-rb, nvidia-patch, Betterfox, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      overlay-2411 = final: prev: {
        stable = import nixpkgs-2411 {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-33.4.11"
          ];
        };
        overlays = [
          nur.overlays.default
          overlay-2411
          nvidia-patch.overlays.default
        ];
      };
      lib = nixpkgs;
      secrets = builtins.fromTOML (builtins.readFile ./secrets/secrets.toml);
    in
    {
      nixosConfigurations = {
        scorpia = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            desktop = false;
            laptop = true;
            server = false;
            wayland = true;
            x = false;
          };
          modules = [
            ./scorpia/configuration.nix
            lix-module.nixosModules.default
            catppuccin.nixosModules.catppuccin
            nixos-hardware.nixosModules.lenovo-ideapad-slim-5
          ];
        };
        entrapta = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            desktop = true;
            laptop = false;
            server = false;
            wayland = true;
            x = false;
          };
          modules = [
            ./entrapta/configuration.nix
            lix-module.nixosModules.default
            catppuccin.nixosModules.catppuccin
          ];
        };
        adora = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            desktop = false;
            laptop = false;
            server = true;
            wayland = false;
            x = false;
            inherit secrets;
          };
          modules = [
            ./adora/configuration.nix
            ./server/default.nix
            lix-module.nixosModules.default
            catppuccin.nixosModules.catppuccin
          ];
        };
      };

      homeConfigurations = {
        scorpia = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
            inherit any-nix-shell;
            inherit nixos-xivlauncher-rb;
            inherit Betterfox;
            inherit secrets;
            desktop = false;
            laptop = true;
            server = false;
            wayland = true;
            x = false;
          };
          modules = [
            ./home.nix
            lix-module.nixosModules.default
            catppuccin.homeModules.catppuccin
          ];
        };
        entrapta = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
            inherit any-nix-shell;
            inherit nixos-xivlauncher-rb;
            inherit Betterfox;
            inherit secrets;
            desktop = true;
            laptop = false;
            server = false;
            wayland = true;
            x = false;
          };
          modules = [
            ./home.nix
            lix-module.nixosModules.default
            catppuccin.homeModules.catppuccin
          ];
        };
        adora = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
            inherit any-nix-shell;
            inherit nixos-xivlauncher-rb;
            inherit Betterfox;
            desktop = false;
            laptop = false;
            server = true;
            wayland = false;
            x = false;
          };
          modules = [
            ./home.nix
            lix-module.nixosModules.default
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}

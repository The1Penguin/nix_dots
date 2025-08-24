{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
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
      url = "github:The1Penguin/nixos-xivlauncher-rb";
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
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, lix-module, home-manager, spicetify-nix, nur, any-nix-shell, catppuccin, nixos-xivlauncher-rb, nvidia-patch, Betterfox, nixos-hardware, niri, ... }:
    let
      system = "x86_64-linux";
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
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
          overlay-stable
          nvidia-patch.overlays.default
          niri.overlays.niri
          (final: prev: {
            any-nix-shell =
              any-nix-shell.outputs.packages.${system}.any-nix-shell;
          })
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
            niri.nixosModules.niri
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
            niri.nixosModules.niri
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
        kyle = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            desktop = false;
            laptop = true;
            server = false;
            wayland = true;
            x = false;
          };
          modules = [
            ./kyle/configuration.nix
            lix-module.nixosModules.default
            catppuccin.nixosModules.catppuccin
            nixos-hardware.nixosModules.microsoft-surface-pro-intel
            niri.nixosModules.niri
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
            niri.homeModules.niri
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
            niri.homeModules.niri
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
        kyle = home-manager.lib.homeManagerConfiguration {
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
            niri.homeModules.niri
          ];
        };
      };
    };
}

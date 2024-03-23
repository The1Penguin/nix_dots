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
        overlays = [
          nur.overlay
          (final: prev: {
            pythonPackagesExtensions =
              prev.pythonPackagesExtensions
              ++ [
                (
                  python-final: python-prev: {
                    catppuccin = python-prev.catppuccin.overridePythonAttrs (oldAttrs: rec {
                      version = "1.3.2";
                      src = prev.fetchFromGitHub {
                        owner = "catppuccin";
                        repo = "python";
                        rev = "refs/tags/v${version}";
                        hash = "sha256-spPZdQ+x3isyeBXZ/J2QE6zNhyHRfyRQGiHreuXzzik=";
                      };

                      # can be removed next version
                      disabledTestPaths = [
                        "tests/test_flavour.py" # would download a json to check correctness of flavours
                      ];
                    });
                  }
                )
              ];
          })
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

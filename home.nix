{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball {
        url = "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
        sha256 = "0dfshsgj93ikfkcihf4c5z876h4dwjds998kvgv7sqbfv0z6a4bc";
    };
in
{
    imports = [
        (import "${home-manager}/nixos")
    ];

    home-manager.users.pingu = {
        home.stateVersion = "23.05";

        home.packages = with pkgs; [
           htop
           emacs
           neovim
           nextcloud-client
           fish
	   firefox
	   kate
	   pavucontrol
	   alacritty
        ];
        
        programs.git = {
            enable = true;
            userName  = "pingu";
            userEmail = "nor@acorneroftheweb.com";
        };

    };

    programs.fish.enable = true;
    users.users.pingu.shell = pkgs.fish;

}

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
           discord
           ranger
           wofi
           spotify
           exa
           bitwarden
           playerctl
           brightnessctl
           pulseaudio
           libnotify
           gcc
           xfce.thunar
           ranger
           bat
        ];

	home.file = {
          ".config/river/init".source = ./configfiles/riverconfig;
	  ".config/river/init".executable = true;

          ".config/kanshi/config".source = ./configfiles/kanshiconfig;

	  ".config/wofi/config".source = ./configfiles/woficonfig;
	  ".config/wofi/wofi.css".source = ./configfiles/wofi.css;
	  ".config/wofi/wofi.css".executable = true;


	  ".config/alacritty/alacritty.yml".source = ./configfiles/alacritty.yml;
	  ".config/alacritty/alacrittycolors.yml".source = ./configfiles/alacrittycolors.yml;

	  ".config/mako/config".source = ./configfiles/makoconfig;

	  ".config/fish/config.fish".source = ./configfiles/config.fish;

	  ".config/nvim/init.lua".source = ./configfiles/nvimconfig;
	};
        
        programs.git = {
            enable = true;
            userName  = "pingu";
            userEmail = "nor@acorneroftheweb.com";
        };

	wayland.windowManager.sway = {
    	  enable = true;
    	    config = rec {
    	      modifier = "Mod4";
    	      terminal = "alacritty"; 
    	      startup = [
    	        # Launch Firefox on start
    	        {command = "firefox";}
    	    ];
    	  };
        };

	programs.neovim.plugins = with pkgs.vimPlugins; [
          lazy-nvim
        ];
    };

    programs.fish.enable = true;
    programs.starship.enable = true;
    programs.starship.settings = {
        format = "$directory";
        right_format = "$hostname";
        add_newline = false;

        hostname= {
          ssh_only = true;
          format = "[$hostname](bold yellow)";
        };

        directory = {
          truncation_length = 0;
          truncation_symbol = "…/";
          truncate_to_repo = false;
          read_only = " 🔒";
          style = "cyan";
        };
    };
    users.users.pingu.shell = pkgs.fish;

    nixpkgs.overlays =
      let
        myOverlay = self: super: {
          discord = super.discord.override { withOpenASAR = true; withVencord = true; };
        };
      in
      [ myOverlay ];
}

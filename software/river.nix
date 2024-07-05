{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    swaylock-effects
    wofi
    brightnessctl
    acpi
    sway-contrib.grimshot
    rivercarro
    swaybg
    (pkgs.writeScriptBin "notify" (builtins.readFile ../scripts/laptop/notify))
    (pkgs.writeScriptBin "wofi_powermenu_w" (builtins.readFile ../scripts/laptop/wofi_powermenu_w))
    (pkgs.writeScriptBin "mylock" (builtins.readFile ../scripts/laptop/mylock))
  ];

  wayland.windowManager.river = {
    enable = true;
    extraConfig = builtins.readFile ../files/riverconfig;
    systemd.enable = true;
    systemd.variables = [
      "DISPLAY"
      "WAYLAND_DISPLAY"
      "XDG_SESSION_TYPE"
      "XDG_CURRENT_DESKTOP"
      "XDG_SESSION_DESKTOP"
      "NIXOS_OZONE_WL"
      "XCURSOR_THEME"
      "XCURSOR_SIZE"
    ];
    systemd.extraCommands = [
      "systemctl --user stop river-session.target"
      "systemctl --user start river-session.target"
      "rivercarro -inner-gaps 3 -outer-gaps 3 -no-smart-gaps -main-ratio 0.63"
    ];
  };

  services = {
    mako = {
      enable = true;
      catppuccin.enable = false;
      extraConfig = builtins.readFile ../files/makoconfig;
    };

    kanshi = {
      enable = true;
      settings = [
        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
            }
          ];
        }
        {
          profile.name = "TV";
          profile.outputs = [
            {
              criteria = "eDP-1";
              position = "0,0";
            }
            {
              criteria = "Samsung Electric Company SAMSUNG 0x00000700";
              position = "1920,0";
              mode = "3840x2160@60Hz";
              scale = 2.0;
            }
          ];
        }
        {
          profile.name = "Monitor_Kumla";
          profile.outputs = [
            {
              criteria = "eDP-1";
              position = "320,1440";
            }
            {
              criteria = "AOC Q32V4WG5 QHPM4HA001642";
              position = "0,0";
              mode = "2560x1440@59.951Hz";
            }
          ];
        }
      ];
    };
  };

  systemd.user.services.kanshi-river = {
    Unit = {
      Description = "Kanshi but on river";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      Restart = "always";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

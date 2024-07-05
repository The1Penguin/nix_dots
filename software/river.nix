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
    (pkgs.writeScriptBin "wofi_powermenu_w" (builtins.readFile  ./../scripts/laptop/wofi_powermenu_w))
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
      extraConfig = builtins.readFile ../files/kanshiconfig;
    };
  };
}

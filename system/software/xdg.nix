{ config, lib, pkgs, fps ? 60, ... }:

{

  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast.max_fps = fps;
    wlr.settings.screencast.chooser_type = "dmenu";
    wlr.settings.screencast.chooser_cmd = "${pkgs.fuzzel}/bin/fuzzel -d -l 10 -p 'Select a source to share:'";
    config.common.default = [ "wlr" "gtk" ];
    config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  };
}

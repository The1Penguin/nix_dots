{ config, lib, pkgs, ... }:

{
  catppuccin.swaync.font = "DokiDokiMono Nerd Font";
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "user";
      control-center-margin-top = 52;
      control-center-margin-bottom = 52;
      control-center-margin-right = 3;
      control-center-margin-left = 3;
      Notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-grouping = true;
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 5;
      text-empty = "No Notifications";
      widgets = [ "title" "dnd" "notifications" "mpris" ];
      widget-config.mpris = {
        autohide = true;
        show-album-art = "when-available";
        loop-carousel = true;
      };
    };
  };
}

{ config, lib, pkgs, desktop, laptop, ... }:

{
  catppuccin.swaync = {
    font = "DokiDokiMono Nerd Font";
    fontSize = if desktop then "16" else if laptop then "18" else "14";
  };
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
      timeout = 8;
      timeout-low = 5;
      timeout-critical = 8;
      text-empty = "No Notifications";
      widgets = [ "title" "notifications" "mpris" ];
      widget-config = {
        mpris = {
          autohide = true;
          show-album-art = "when-available";
          loop-carousel = true;
        };
      };
    };
  };
}

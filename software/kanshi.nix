{ config, lib, pkgs, ... }:

{

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "kyle";
        profile.outputs = [
          {
            criteria = "LG Display 0x0555 0x100000A1";
            mode = "2736x1824";
            scale = 2.0;
          }
        ];
      }

      {
        profile.name = "TV";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
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
            mode = "1920x1200";
            position = "1920,1080";
          }
          {
            criteria = "HP Inc. HP E24 G5 CNK42417YG";
            position = "0,0";
            mode = "1920x1080@75Hz";
          }
          {
            criteria = "DP-2";
            position = "1920,0";
            mode = "1920x1080@75Hz";
          }
        ];
      }
      {
        profile.name = "NC";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
            position = "0,0";
          }
          {
            criteria = "Dell Inc. DELL P2422H H0T55V3";
            position = "0,-1200";
            mode = "1920x1080@60Hz";
          }
        ];
      }
      {
        profile.name = "Desktop";
        profile.outputs = [
          {
            criteria = "Acer Technologies XV270 V 0x029144B9";
            position = "0,0";
            mode = "1920x1080@164.994995Hz";
            adaptiveSync = true;
          }
          {
            criteria = "Acer Technologies Acer XF240H 0x6240186E";
            position = "1920,0";
            mode = "1920x1080@144.001007Hz";
            adaptiveSync = true;
          }
        ];
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200";
          }
        ];
      }
    ];
  };
}

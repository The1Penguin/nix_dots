{ config, lib, pkgs, ... }:

{
  services.udev.packages = [
      (pkgs.writeTextFile {
        name = "51-tkey.rules";
        destination = "/lib/udev/rules.d/51-tkey.rules";
        text = ''
          ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1207", ATTRS{idProduct}=="8887", ENV{ID_SECURITY_TOKEN}="1", MODE="0660", GROUP="tkey"
        '';
      })
    ];

}

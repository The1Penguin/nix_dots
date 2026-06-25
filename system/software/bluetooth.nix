{ config, lib, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
    package = pkgs.bluez-experimental;
  };
}

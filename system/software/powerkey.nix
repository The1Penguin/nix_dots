{ config, lib, pkgs, ... }:

{
  services.logind.settings.Login.HandlePowerKey = "ignore";
}

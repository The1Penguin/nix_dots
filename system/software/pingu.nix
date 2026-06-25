{ config, lib, pkgs, ... }:

{
  users.users.pingu = {
    isNormalUser = true;
    description = "pingu";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "uinput" "input" "tkey" ];
    shell = pkgs.fish;
  };
}

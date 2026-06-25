{ config, lib, pkgs, ... }:

{
  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "latte";
    accent = "pink";
  };
}

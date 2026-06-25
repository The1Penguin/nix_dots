{ config, lib, pkgs, ... }:

{
  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "latte";
    accent = "pink";
    sddm = {
      background = ../../sakuraflower.png;
      font = "Monaspace Neon NF";
    };
  };
}

{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
  ];

  environment.variables = { EDITOR = "vim"; };
}

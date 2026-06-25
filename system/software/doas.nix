{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    doas-sudo-shim
    (writeShellScriptBin "doasedit" (builtins.readFile ../../scripts/doasedit))
    (writeShellScriptBin "sudoedit" (builtins.readFile ../../scripts/doasedit))
  ];
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        runAs = "root";
        groups = [ "wheel" ];
        persist = true;
        noPass = false;
        keepEnv = true;
      }];
    };
  };
}

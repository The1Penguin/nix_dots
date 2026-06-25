{ config, lib, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 500;
      height = 300;
      always_parse_args = true;
      show_all = true;
      print_command = true;
      layer = "overlay";
      insensitive = true;
      content_halign = "center";
      prompt = "";
    };
    style = ''
      window {
        margin: 0px;
        border: 2px solid #eff1f5;
        border-radius: 0px;
        background-color: #eff1f5;
        font-family: Monaspace Neon NF;
        font-size: 16px;
      }

      #input {
        margin: 15px;
        border: 1px solid #eff1f5;
        border-radius: 15px;
        color: #4c4f69;
        background-color: #eff1f5;
      }

      #input image {
        color: #4c4f69;
      }

      #inner-box {
        margin: 5px;
        border: none;
        padding-left: 10px;
        padding-right: 10px;
        background-color: #eff1f5;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #eff1f5;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #4c4f69;
      }

      #entry {
        padding-left: 20px;
        padding-right: 20px;
      }

      #entry:selected {
        background-color: #ea76cb;
        font-weight: normal;
        border-radius: 15px;
      }

      #text:selected {
        background-color: #ea76cb;
        color: #4c4f69;
        font-weight: normal;
      }
    '';
  };
}

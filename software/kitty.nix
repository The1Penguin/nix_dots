{ config, lib, pkgs, ... }:

let dokidokimono = import ./dokidokimono.nix { inherit pkgs; }; in

{
  programs.kitty = {
    enable = true;
    font = {
      name = "family=\"DokiDokiMono Nerd Font\" wght=380";
      package = dokidokimono;
      size = 16;
    };
    shellIntegration = {
      mode = "no-title";
      enableFishIntegration = true;
    };
    settings = {
      window_padding_width = "2 3";
      background_opacity = 0.93;
      font_features = "none";
      text_composition_strategy = "1.3 15";
      "modify_font baseline" = -2;
      "modify_font cell_width" = -1;
      "modify_font cell_height" = 0.5;
    };
  };
}

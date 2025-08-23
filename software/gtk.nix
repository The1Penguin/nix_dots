{ config, lib, pkgs, ... }:

let
  dokidokimono = import ./dokidokimono.nix { inherit pkgs; };
in
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 30;
    };
    iconTheme = {
      name = lib.mkDefault "Zafiro-icons";
      package = lib.mkDefault pkgs.zafiro-icons;
    };
    gtk3 = {
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=0
          gtk-dialogs-use-header=false
        '';
        extraCss = ''
          headerbar.default-decoration {
            margin-bottom: 50px;
            margin-top: -100px;
          }
          window.csd,             /* gtk4? */
          window.csd decoration { /* gtk3 */
            box-shadow: none;
          }
        '';
      };
    };
    gtk4 = {
      extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=0
          gtk-dialogs-use-header=false
        '';
      };
      extraCss = ''
        headerbar.default-decoration {
          margin-bottom: 50px;
          margin-top: -100px;
        }
        window.csd,             /* gtk4? */
        window.csd decoration { /* gtk3 */
          box-shadow: none;
        }
      '';
    };
    font = {
      name = "DokiDokiMono Nerd Font";
      package = dokidokimono;
      size = 12;
    };
  };
}

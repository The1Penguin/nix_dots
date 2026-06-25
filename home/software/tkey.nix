{ config, lib, pkgs, ... }:

let socket = "\${XDG_RUNTIME_DIR}/ssh-agent"; in
{
  systemd.user.services.tkey-ssh-agent = {
    Unit = {
      description = "TKey SSH Agent";
      partOf = [ "default.target" ];
      Documentation = "https://github.com/tillitis/tkey-ssh-agent";
    };


    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${pkgs.tkey-ssh-agent}/bin/tkey-ssh-agent --uss --pinentry ${pkgs.pinentry-all}/bin/pinentry-gnome3 --agent-socket ${socket}";

    };
  };

  home = {
    packages = [ pkgs.pinentry-all ];
    sessionVariables = {
      SSH_AUTH_SOCK = socket;
    };
  };
}

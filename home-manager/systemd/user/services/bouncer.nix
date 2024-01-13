{ pkgs }:
{
  Unit = {
    Description = "Service Init Bouncer";
  };
  Install = {
    WantedBy = [ "default.target" ];
  };
  Service = {
    ExecStart = toString (pkgs.writeShellScript "service-bouncer" ''
      #!/usr/bin/env bash
      PATH=/run/current-system/sw/bin:$PATH
      sleep 5
      systemctl --user restart polybar.service
      systemctl --user restart wallpaper-switcher.service
    '');
  };
}

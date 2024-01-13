{ homeDirectory, pkgs }:
{
  Unit = {
    Description = "Wallpaper Switcher Service";
  };
  Install = {
    WantedBy = [ "default.target" ];
  };
  Service = {
    ExecStart = toString (pkgs.writeShellScript "wallpaper-switcher" ''
      #!/usr/bin/env bash
      WP_DIR='${homeDirectory}/documents/wallpaper/widescreen'
      PATH=/run/current-system/sw/bin:$PATH
      while true
      do
          filesleft=($(find "$WP_DIR" -type f | shuf))
          for fileleft in "$filesleft"; do
              fileright=($(find "$WP_DIR" -type f | shuf | head -n 1))
              filecenter=($(find "$WP_DIR" -type f | shuf | head -n 1))
              echo $fileleft $filecenter $fileright
              ${pkgs.feh}/bin/feh --bg-fill "$fileleft" "$filecenter" "$fileright"
              sleep 60.0
          done
      done
    '');
  };
}

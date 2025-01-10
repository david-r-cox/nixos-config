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

      # Toggle between modes (0: random switcher, 1: static)
      MODE=1

      # Pre-defined static wallpaper paths
      STATIC_CENTER="$WP_DIR/6zlp1jd1ar691.png"
      STATIC_LEFT="$WP_DIR/6zlp1jd1ar691.png"
      STATIC_RIGHT="$WP_DIR/6zlp1jd1ar691.png"

      # Sleep duration for each mode (in seconds)
      RANDOM_SLEEP=60

      if [ $MODE -eq 0 ]; then
        # Random switcher mode
        while true
        do
          filesleft=($(find "$WP_DIR" -type f | shuf))
          for fileleft in "$filesleft"; do
              fileright=($(find "$WP_DIR" -type f | shuf | head -n 1))
              filecenter=($(find "$WP_DIR" -type f | shuf | head -n 1))
              echo $fileleft $filecenter $fileright
              ${pkgs.feh}/bin/feh --bg-fill "$fileleft" "$filecenter" "$fileright"
              sleep $RANDOM_SLEEP
          done
        done
      else
        # Static wallpaper mode
        echo $STATIC_LEFT $STATIC_CENTER $STATIC_RIGHT
        ${pkgs.feh}/bin/feh --bg-fill "$STATIC_LEFT" "$STATIC_CENTER" "$STATIC_RIGHT"
        # No need for a loop in static mode, it sets once and exits
      fi
    '');
  };
}

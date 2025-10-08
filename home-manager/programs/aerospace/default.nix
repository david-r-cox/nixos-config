{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
lib.mkIf isDarwin {
  xdg.configFile."aerospace/aerospace.toml".text = ''
    start-at-login = true
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true
    accordion-padding = 8
    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'
    automatically-unhide-macos-hidden-apps = true

    [key-mapping]
        preset = 'qwerty'

    [gaps]
        inner.horizontal = 4
        inner.vertical =   4
        outer.left =       4
        outer.bottom =     4
        outer.top =        4
        outer.right =      4

    [mode.main.binding]
        ctrl-alt-space = 'layout tiles horizontal vertical'
        ctrl-alt-shift-space = 'layout accordion horizontal vertical'
        # Fullscreen without preserving outer gaps so windows cover the monitor
        ctrl-alt-f = 'fullscreen --no-outer-gaps'
        ctrl-alt-shift-f = 'layout floating tiling'

        ctrl-alt-j = 'focus down'
        ctrl-alt-k = 'focus up'
        ctrl-alt-h = 'resize smart -50'
        ctrl-alt-l = 'resize smart +50'
        ctrl-alt-b = 'balance-sizes'
        ctrl-alt-m = 'focus-back-and-forth'

        ctrl-alt-shift-j = 'move down'
        ctrl-alt-shift-k = 'move up'
        ctrl-alt-shift-h = 'move left'
        ctrl-alt-shift-l = 'move right'

        ctrl-alt-enter = 'exec-and-forget /usr/bin/open -a Alacritty'

        ctrl-alt-w = 'focus-monitor 1'
        ctrl-alt-e = 'focus-monitor 2'
        ctrl-alt-r = 'focus-monitor 3'

        ctrl-alt-shift-w = 'move-node-to-monitor 1'
        ctrl-alt-shift-e = 'move-node-to-monitor 2'
        ctrl-alt-shift-r = 'move-node-to-monitor 3'

        ctrl-alt-1 = 'workspace 1'
        ctrl-alt-2 = 'workspace 2'
        ctrl-alt-3 = 'workspace 3'
        ctrl-alt-4 = 'workspace 4'
        ctrl-alt-5 = 'workspace 5'
        ctrl-alt-6 = 'workspace 6'
        ctrl-alt-7 = 'workspace 7'
        ctrl-alt-8 = 'workspace 8'
        ctrl-alt-9 = 'workspace 9'

        ctrl-alt-shift-1 = 'move-node-to-workspace 1'
        ctrl-alt-shift-2 = 'move-node-to-workspace 2'
        ctrl-alt-shift-3 = 'move-node-to-workspace 3'
        ctrl-alt-shift-4 = 'move-node-to-workspace 4'
        ctrl-alt-shift-5 = 'move-node-to-workspace 5'
        ctrl-alt-shift-6 = 'move-node-to-workspace 6'
        ctrl-alt-shift-7 = 'move-node-to-workspace 7'
        ctrl-alt-shift-8 = 'move-node-to-workspace 8'
        ctrl-alt-shift-9 = 'move-node-to-workspace 9'

        ctrl-alt-shift-c = 'close'

        ctrl-alt-semicolon = 'mode service'

    [mode.service.binding]
        esc = ['reload-config', 'mode main']
        r = ['flatten-workspace-tree', 'mode main']
        f = ['layout floating tiling', 'mode main']
        backspace = ['close-all-windows-but-current', 'mode main']

        ctrl-alt-shift-h = ['join-with left', 'mode main']
        ctrl-alt-shift-j = ['join-with down', 'mode main']
        ctrl-alt-shift-k = ['join-with up', 'mode main']
        ctrl-alt-shift-l = ['join-with right', 'mode main']
  '';
}

{
  ".config/polybar/config.ini".text = builtins.readFile (./polybar/config.ini);
  # wd required a mutable warprc file:
  #".warprc".text = builtins.readFile (./wd/warprc);
}

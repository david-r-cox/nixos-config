{ homeDirectory, pkgs }:

{
  wallpaper-switcher = import ./wallpaper-switcher.nix {
    inherit homeDirectory;
    inherit pkgs;
  };
  bouncer = import ./bouncer.nix {
    inherit pkgs;
  };

}

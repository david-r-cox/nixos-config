_:
{
  enable = true;
  enableContribAndExtras = true;
  extraPackages = haskellPackages: [
    haskellPackages.data-default
    haskellPackages.dbus
    haskellPackages.ghc
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
  ];
  config = ./xmonad.hs;
}

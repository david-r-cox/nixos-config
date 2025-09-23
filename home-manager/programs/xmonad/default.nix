{ lib, pkgs, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
in
lib.mkIf isLinux {
  xsession.windowManager.xmonad = {
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
  };
}

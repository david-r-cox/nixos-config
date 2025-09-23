{ pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
in
lib.mkIf isLinux {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "gruvbox-dark";
    plugins = [ pkgs.rofi-calc ];
  };
}

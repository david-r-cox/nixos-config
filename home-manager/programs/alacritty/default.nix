{ pkgs, lib, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
  colorscheme = import ../../colorschemes/gruvbox_light.nix;
  family = "FiraCode Nerd Font Mono";
in
lib.mkIf isLinux {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = colorscheme;
      font = {
        size = 8;
        normal = {
          inherit family;
          style = "Regular";
        };
        bold = {
          inherit family;
          style = "Bold";
        };
        italic = {
          inherit family;
          style = "Italic";
        };
        bold_italic = {
          inherit family;
          style = "Bold Italic";
        };
      };
      terminal.shell.program = "${pkgs.zsh}/bin/zsh";
      window.opacity = 0.95;
    };
  };
}

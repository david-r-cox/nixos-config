{ pkgs }:
{
  enable = true;
  terminal = "${pkgs.alacritty}/bin/alacritty";
  theme = "gruvbox-dark";
  plugins = [ pkgs.rofi-calc ];
}

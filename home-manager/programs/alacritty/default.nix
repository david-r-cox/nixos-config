{ colorscheme, pkgs }:
let
  family = "FiraCode Nerd Font Mono";
in
{
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
    shell.program = "${pkgs.zsh}/bin/zsh";
    window.opacity = 1.00;
  };
}

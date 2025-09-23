{ pkgs, lib, ... }:
let
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  home.file = lib.mkMerge [
    {
      ".local/share/fonts/NerdFonts" = {
        source = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode";
        recursive = true;
      };
    }
    (lib.mkIf isLinux {
      ".config/polybar/config.ini".text = builtins.readFile ./polybar/config.ini;
    })
    (lib.mkIf isDarwin {
      "Library/Application Support/iTerm2/com.googlecode.iterm2.plist".text =
        builtins.readFile ./iterm2/iterm2.plist;
    })
  ];
}

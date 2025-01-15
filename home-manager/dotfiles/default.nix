{pkgs}:
{
  ".config/polybar/config.ini".text = builtins.readFile (./polybar/config.ini);
  # wd required a mutable warprc file:
  #".warprc".text = builtins.readFile (./wd/warprc);
  # required to resolve alacritty font loading bug: https://t.ly/Jrx_q
  ".local/share/fonts/NerdFonts" = {
    source = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode";
    recursive = true;
  };
}

{
  enable = true;
  settings = {
    add_newline = false;
    character = {
      success_symbol = "[➜](bold green)";
      error_symbol = "[➜](bold red)";
    };
    line_break.disabled = true;
    format = "$os$all";
    os = {
      format = "[($name $symbol $version)]($style) ";
      style = "bold blue";
      disabled = true;
      symbols = {
        Alpine = "🏔️";
        Amazon = "🙂";
        Arch = "🎗️";
        Debian = "🌀";
        FreeBSD = "😈";
        Gentoo = "🗜️";
        Linux = "🐧";
        Macos = "🍎";
        NixOS = "❄️";
        OpenBSD = "🐡";
        Raspbian = "🍓";
        Unknown = "❓";
      };
    };
    shell = {
      nu_indicator = "ν";
      zsh_indicator = "ζ";
      bash_indicator = "β";
      style = "bold green";
      disabled = false;
    };
    sudo = {
      disabled = false;
    };
  };
}

{ pkgs, lib, ... }:
rec {
  home.stateVersion = "23.05";

  home = {
    username = "david";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${home.username}"
      else "/home/${home.username}";
    file = import ./dotfiles;
    sessionVariables = import ./session;
    packages = import ./packages { inherit pkgs; };
  };

  fonts.fontconfig.enable = true;

  programs = {
    bash = import programs/bash;
    broot = import programs/broot;
    fzf = import programs/fzf;
    git = import programs/git
      {
        isCorp = false;
      };
    home-manager.enable = true;
    neovim = import programs/neovim { inherit pkgs; };
    nix-index = import programs/nix-index;
    zsh = import programs/zsh { inherit pkgs; };
  } // lib.optionalAttrs pkgs.stdenv.isLinux {
    alacritty = import programs/alacritty {
      colorscheme = import ./colorschemes/ayu_dark.nix;
      inherit pkgs;
    };
    rofi = import ./programs/rofi { inherit pkgs; };
  };

  systemd = lib.optionalAttrs pkgs.stdenv.isLinux {
    user.services = import systemd/user/services {
      inherit (home) homeDirectory;
      inherit pkgs;
    };
  };
  services = lib.optionalAttrs pkgs.stdenv.isLinux {
    polybar = {
      enable = true;
      script = "polybar -c ~/.config/polybar/config.ini &";
    };
  };
  xdg = lib.optionalAttrs pkgs.stdenv.isLinux {
    configFile = import ./xdg/config;
  };
}

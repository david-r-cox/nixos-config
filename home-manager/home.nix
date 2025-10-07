{ pkgs, lib, ... }:
let
  username = "david";
  inherit (pkgs.stdenv) isLinux;
  inherit (pkgs.stdenv) isDarwin;
in
rec {
  imports = [
    ./dotfiles
    ./session
    ./programs/alacritty
    ./programs/bash
    ./programs/broot
    ./programs/carapace
    ./programs/fzf
    ./programs/git
    ./programs/ghostty
    ./programs/neovim
    ./programs/nix-index
    ./programs/nushell
    ./programs/rofi
    ./programs/starship
    ./programs/xmonad
    ./programs/zsh
    ./systemd/user/services
  ];

  home.stateVersion = "23.05";

  home = {
    inherit username;
    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
    packages = import ./packages { inherit pkgs; };
    enableNixpkgsReleaseCheck = false;
  };

  fonts.fontconfig.enable = true;
  nix.package = pkgs.nixVersions.latest;
  # This causes warnings but might be required for ccache?
  #  nix.settings = {
  #    extra-sandbox-paths = [
  #      "/tmp/ccache"
  #    ];
  #    sandbox = true;
  #  };

  programs = {
    home-manager.enable = true;
    lazygit = {
      enable = true;
      package = pkgs.lazygit;
      settings.git.overrideGpg = true;
    };
    emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages =
        epkgs: with epkgs; [
          evil
          use-package
          which-key
          magit
        ];
    };
  };

  services = lib.mkIf isLinux {
    polybar = {
      enable = true;
      script =
        let
          configFile = "~/.config/polybar/config.ini";
        in
        ''
          polybar main -c ${configFile} & \
          polybar main-bottom -c ${configFile} & \
          polybar secondary -c ${configFile} & \
          polybar secondary-bottom -c ${configFile} &
        '';
    };
  };
}

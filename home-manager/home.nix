{ pkgs, lib, ... }:
let
  username = "david";
  inherit (pkgs.stdenv) isLinux;
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib) optionalAttrs;
in
rec {
  home.stateVersion = "23.05";

  home = {
    inherit username;
    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
    file = import ./dotfiles { inherit pkgs; };
    sessionVariables = import ./session;
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

  programs =
    {
      bash = import programs/bash;
      broot = import programs/broot;
      carapace = import programs/carapace;
      fzf = import programs/fzf;
      git = import programs/git { isCorp = true; };
      home-manager.enable = true;
      lazygit = {
        enable = true;
        package = pkgs.lazygit;
        settings = {
          git = {
            overrideGpg = true;
          };
        };
      };
      neovim = import programs/neovim { inherit pkgs; };
      nix-index = import programs/nix-index;
      nushell = import programs/nushell;
      starship = import programs/starship;
      zsh = import programs/zsh { inherit pkgs; };
      emacs = {
        enable = true;
        package = pkgs.emacs;
        extraPackages = epkgs: with epkgs; [
          evil
          use-package
          which-key
          magit
        ];
      };
    }
    // optionalAttrs isLinux {
      alacritty = import programs/alacritty {
        colorscheme = import ./colorschemes/gruvbox_light.nix;
        inherit pkgs;
      };
      rofi = import ./programs/rofi {
        inherit pkgs;
      };
    };

  systemd = optionalAttrs isLinux {
    user.services = import systemd/user/services {
      inherit (home) homeDirectory;
      inherit pkgs;
    };
  };

  services = optionalAttrs isLinux {
    polybar = {
      enable = true;
      script = let
        configFile = "~/.config/polybar/config.ini";
      in ''
        polybar main -c ${configFile} & \
        polybar main-bottom -c ${configFile} & \
        polybar secondary -c ${configFile} & \
        polybar secondary-bottom -c ${configFile} &
      '';
    };
  };
  xsession = optionalAttrs isLinux {
    windowManager.xmonad = import ./programs/xmonad { };
  };
}

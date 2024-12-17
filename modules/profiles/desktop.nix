{ config, lib, pkgs, ... }:

{
  options.mySystem.profiles.desktop = {
    enable = lib.mkEnableOption "desktop profile";

    displayManager = lib.mkOption {
      type = lib.types.enum [ "gdm" "lightdm" "sddm" ];
      default = "gdm";
      description = "Desktop display manager";
    };

    windowManager = lib.mkOption {
      type = lib.types.enum [ "xmonad" "i3" "awesome" ];
      default = "xmonad";
      description = "Window manager";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Additional desktop packages";
    };
  };

  config = lib.mkIf config.mySystem.profiles.desktop.enable {
    # X11 configuration
    services.xserver = {
      enable = true;

      displayManager = {
        gdm.enable = config.mySystem.profiles.desktop.displayManager == "gdm";
        lightdm.enable = config.mySystem.profiles.desktop.displayManager == "lightdm";
        sddm.enable = config.mySystem.profiles.desktop.displayManager == "sddm";
      };

      windowManager = {
        xmonad.enable = config.mySystem.profiles.desktop.windowManager == "xmonad";
        i3.enable = config.mySystem.profiles.desktop.windowManager == "i3";
        awesome.enable = config.mySystem.profiles.desktop.windowManager == "awesome";
      };
    };

    # Desktop environment
    environment.systemPackages = with pkgs; [
      # Window management
      polybar
      rofi
      feh
      dunst
      picom

      # Applications
      alacritty
      firefox
      chromium
      thunderbird

      # Development
      vscode
      neovide

      # System tools
      pavucontrol
      arandr
      xclip
    ] ++ config.mySystem.profiles.desktop.extraPackages;

    # Audio
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Power management
    services.thermald.enable = true;
    services.tlp.enable = true;

    # Fonts
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
        font-awesome
        liberation_ttf
      ];
    };

    # Default applications
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}

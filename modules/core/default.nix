{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./users.nix
  ];

  options = {
    mySystem.core = {
      enable = lib.mkEnableOption "core system configuration";
      
      settings = lib.mkOption {
        type = lib.types.submodule {
          options = {
            defaultLocale = lib.mkOption {
              type = lib.types.str;
              default = "en_US.UTF-8";
              description = "Default system locale";
            };
            
            defaultTimezone = lib.mkOption {
              type = lib.types.str;
              default = "UTC";
              description = "Default system timezone";
            };
            
            hostName = lib.mkOption {
              type = lib.types.str;
              description = "System hostname";
            };
          };
        };
        default = {};
        description = "Core system settings";
      };
    };
  };

  config = lib.mkIf config.mySystem.core.enable {
    # Basic system configuration
    time.timeZone = config.mySystem.core.settings.defaultTimezone;
    
    i18n.defaultLocale = config.mySystem.core.settings.defaultLocale;
    
    networking = {
      hostName = config.mySystem.core.settings.hostName;
      useDHCP = false;  # Configured per-interface
    };

    # Essential packages
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
      curl
    ];

    # System maintenance
    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}

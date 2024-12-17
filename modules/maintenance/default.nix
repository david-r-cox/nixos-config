{ config, lib, pkgs, ... }:

{
  imports = [
    ./backup.nix
    ./monitoring.nix
  ];

  options.mySystem.maintenance = {
    enable = lib.mkEnableOption "system maintenance";

    cleanup = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable automatic cleanup";
      };

      interval = lib.mkOption {
        type = lib.types.str;
        default = "weekly";
        description = "Cleanup interval";
      };

      oldGenerations = lib.mkOption {
        type = lib.types.int;
        default = 30;
        description = "Days to keep old generations";
      };
    };
  };

  config = lib.mkIf config.mySystem.maintenance.enable {
    # Automatic cleanup
    nix = {
      settings.auto-optimise-store = true;
      gc = lib.mkIf config.mySystem.maintenance.cleanup.enable {
        automatic = true;
        dates = config.mySystem.maintenance.cleanup.interval;
        options = "--delete-older-than ${toString config.mySystem.maintenance.cleanup.oldGenerations}d";
      };
    };

    # System maintenance tools
    environment.systemPackages = with pkgs; [
      htop
      iotop
      lsof
      smartmontools
      sysstat
    ];

    # Disk health monitoring
    services.smartd = {
      enable = true;
      autodetect = true;
      notifications = {
        wall.enable = true;
      };
    };

    # Log rotation
    services.logrotate = {
      enable = true;
      settings = {
        compress = true;
        dateext = true;
        maxage = 365;
        rotate = 7;
      };
    };
  };
}

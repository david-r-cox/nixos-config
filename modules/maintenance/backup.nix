{ config, lib, pkgs, ... }:

{
  options.mySystem.maintenance.backup = {
    enable = lib.mkEnableOption "backup configuration";

    borg = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Borg backup";
      };

      repo = lib.mkOption {
        type = lib.types.str;
        description = "Borg repository location";
      };

      paths = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "/home" "/etc" ];
        description = "Paths to backup";
      };

      exclude = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "*.pyc" "__pycache__" ];
        description = "Patterns to exclude";
      };

      encryption = {
        mode = lib.mkOption {
          type = lib.types.enum [ "none" "repokey" "keyfile" ];
          default = "repokey";
          description = "Encryption mode";
        };

        passCommand = lib.mkOption {
          type = lib.types.str;
          description = "Command to get encryption password";
        };
      };

      compression = lib.mkOption {
        type = lib.types.str;
        default = "auto,lzma";
        description = "Compression algorithm";
      };

      schedule = {
        minute = lib.mkOption {
          type = lib.types.str;
          default = "0";
          description = "Minute of backup";
        };

        hour = lib.mkOption {
          type = lib.types.str;
          default = "2";
          description = "Hour of backup";
        };

        day = lib.mkOption {
          type = lib.types.str;
          default = "*";
          description = "Day of backup";
        };
      };
    };

    zfs = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable ZFS snapshots";
      };

      interval = lib.mkOption {
        type = lib.types.str;
        default = "hourly";
        description = "Snapshot interval";
      };

      keep = {
        hourly = lib.mkOption {
          type = lib.types.int;
          default = 24;
          description = "Hourly snapshots to keep";
        };

        daily = lib.mkOption {
          type = lib.types.int;
          default = 7;
          description = "Daily snapshots to keep";
        };

        weekly = lib.mkOption {
          type = lib.types.int;
          default = 4;
          description = "Weekly snapshots to keep";
        };

        monthly = lib.mkOption {
          type = lib.types.int;
          default = 12;
          description = "Monthly snapshots to keep";
        };
      };
    };
  };

  config = lib.mkIf config.mySystem.maintenance.backup.enable {
    # Borg backup
    services.borgbackup.jobs = lib.mkIf config.mySystem.maintenance.backup.borg.enable {
      system = {
        paths = config.mySystem.maintenance.backup.borg.paths;
        exclude = config.mySystem.maintenance.backup.borg.exclude;
        repo = config.mySystem.maintenance.backup.borg.repo;
        encryption = {
          mode = config.mySystem.maintenance.backup.borg.encryption.mode;
          passCommand = config.mySystem.maintenance.backup.borg.encryption.passCommand;
        };
        compression = config.mySystem.maintenance.backup.borg.compression;
        startAt = "${config.mySystem.maintenance.backup.borg.schedule.minute} ${config.mySystem.maintenance.backup.borg.schedule.hour} * * *";
      };
    };

    # ZFS snapshots
    services.sanoid = lib.mkIf config.mySystem.maintenance.backup.zfs.enable {
      enable = true;
      interval = config.mySystem.maintenance.backup.zfs.interval;
      datasets = {
        "zpool/home" = {
          hourly = config.mySystem.maintenance.backup.zfs.keep.hourly;
          daily = config.mySystem.maintenance.backup.zfs.keep.daily;
          weekly = config.mySystem.maintenance.backup.zfs.keep.weekly;
          monthly = config.mySystem.maintenance.backup.zfs.keep.monthly;
          autosnap = true;
          autoprune = true;
        };
      };
    };

    # Backup tools
    environment.systemPackages = with pkgs; [
      borgbackup
      restic
      rclone
    ];
  };
}

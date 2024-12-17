{ config, lib, pkgs, ... }:

{
  options.mySystem.services.zfs = {
    enable = lib.mkEnableOption "ZFS configuration";

    pools = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "ZFS pool name";
          };

          datasets = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule {
              options = {
                mountPoint = lib.mkOption {
                  type = lib.types.str;
                  description = "Dataset mount point";
                };

                options = lib.mkOption {
                  type = lib.types.attrsOf lib.types.str;
                  default = {};
                  description = "Dataset options";
                };
              };
            });
            default = {};
            description = "Pool datasets";
          };

          scrub = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = true;
              description = "Enable automatic scrubbing";
            };

            interval = lib.mkOption {
              type = lib.types.str;
              default = "monthly";
              description = "Scrub interval";
            };
          };

          trim = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = true;
              description = "Enable TRIM";
            };

            interval = lib.mkOption {
              type = lib.types.str;
              default = "weekly";
              description = "TRIM interval";
            };
          };
        };
      });
      default = [];
      description = "ZFS pools configuration";
    };

    arcSize = {
      max = lib.mkOption {
        type = lib.types.int;
        default = 8 * 1024 * 1024 * 1024; # 8GB
        description = "Maximum ARC size in bytes";
      };
    };

    l2arc = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable L2ARC configuration";
      };

      writebackSize = lib.mkOption {
        type = lib.types.int;
        default = 32 * 1024 * 1024; # 32MB
        description = "L2ARC write size";
      };
    };
  };

  config = lib.mkIf config.mySystem.services.zfs.enable {
    # Base ZFS support
    boot = {
      supportedFilesystems = [ "zfs" ];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      
      kernelParams = [
        "zfs.zfs_arc_max=${toString config.mySystem.services.zfs.arcSize.max}"
      ];
      
      zfs = {
        enableUnstable = true;
        requestEncryptionCredentials = true;
      };
    };

    # ZFS services
    services.zfs = {
      autoScrub = {
        enable = true;
        interval = "monthly";
        pools = map (pool: pool.name) config.mySystem.services.zfs.pools;
      };

      trim = {
        enable = true;
        interval = "weekly";
      };
    };

    # L2ARC configuration
    boot.extraModprobeConfig = lib.mkIf config.mySystem.services.zfs.l2arc.enable ''
      options zfs l2arc_write_max=${toString config.mySystem.services.zfs.l2arc.writebackSize}
      options zfs l2arc_noprefetch=0
    '';

    # Pool configuration
    systemd.services = lib.mkMerge (map (pool:
      let
        name = pool.name;
      in
      {
        "zfs-mount-${name}" = {
          requires = [ "zfs-import-${name}.service" ];
          after = [ "zfs-import-${name}.service" ];
        };
      }
    ) config.mySystem.services.zfs.pools);

    # Monitoring
    environment.systemPackages = with pkgs; [
      zfs-progs
      zfs-autobackup
      sanoid
    ];
  };
}

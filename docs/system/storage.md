# Storage Configuration

This system uses ZFS as its primary storage solution, providing robust data management, integrity checking, and performance optimization features.

## Overview

The storage configuration implements:

- Separate ZFS datasets for different system components
- L2ARC caching for improved performance
- Regular scrubbing for data integrity
- TRIM support for SSDs
- Real-time monitoring via Polybar

## ZFS Configuration

### Dataset Layout

```plaintext
zpool/
├── root/     # Root filesystem
├── nix/      # Nix store
├── home/     # User home directories
└── var/      # System variable data
```

### System Configuration

```nix
{
  # Use ZFS-compatible kernel
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  
  # Configure ZFS parameters
  boot.kernelParams = [
    # Set ARC (ZFS cache) maximum size to 128GB
    "zfs.zfs_arc_max=137438953472"
  ];
  
  boot.supportedFilesystems = [ "zfs" ];
  
  # Bootloader configuration
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # L2ARC tuning
  boot.extraModprobeConfig = ''
    options zfs l2arc_noprefetch=0 l2arc_write_boost=33554432 l2arc_write_max=16777216
  '';

  # Maintenance services
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
    };
    trim.enable = true;
  };
}
```

## Performance Optimization

### ARC Configuration

The ARC (Adaptive Replacement Cache) is configured with a maximum size of 128GB to provide optimal caching while leaving memory available for applications.

### L2ARC Tuning

L2ARC parameters are optimized for:
- Improved write performance with `l2arc_write_boost`
- Controlled cache growth with `l2arc_write_max`
- Efficient prefetch behavior

## Monitoring

### Polybar Integration

ZFS status is monitored in real-time via Polybar, displaying:
- Pool capacity usage
- Dataset sizes
- Free space
- Health status

Configuration:
```ini
[module/zfs]
type = custom/script
exec = zpool list -H -o name,cap,size,alloc,free | awk '{used=$2+0; printf "%s:%s%s%s %s/%s", $1, (used<75?"%{F#50FA7B}":(used<90?"%{F#FFB86C}":"%{F#FF5555}")), $2, "%{F-}", $3, $5}'
interval = 30
format-prefix = "ZFS "
format-prefix-foreground = ${colors.primary}
```

## Maintenance Procedures

### Regular Maintenance

1. **Scrubbing**: Automatically performed weekly
2. **TRIM**: Automatically executed for SSD optimization
3. **Monitoring**: Check Polybar status regularly

### Manual Operations

#### Create a Snapshot
```bash
zfs snapshot zpool/home@backup-$(date +%Y%m%d)
```

#### List Snapshots
```bash
zfs list -t snapshot
```

#### Rollback to Snapshot
```bash
zfs rollback zpool/home@backup-20240101
```

## Historical Note

Previously, this system used BTRFS with the bees deduplication service. While ZFS is now the primary filesystem, the BTRFS configuration is maintained in documentation for reference purposes.

## Future Enhancements

Planned improvements include:
- [ ] Implementing automatic snapshots
- [ ] Enabling remote unlock capability
- [ ] Setting up deduplication for specific datasets
- [ ] Configuring scheduled backups

## Troubleshooting

### Common Issues

1. **Pool Import Failures**
   ```bash
   zpool import -f zpool
   ```

2. **Dataset Mount Issues**
   ```bash
   zfs mount -a
   ```

3. **Cache Performance**
   ```bash
   arc_summary
   ```

### Getting Help

For additional assistance:
1. Check `zpool status` output
2. Review system logs: `journalctl -u zfs-import-cache`
3. Consult the [ZFS documentation](https://openzfs.github.io/openzfs-docs/)
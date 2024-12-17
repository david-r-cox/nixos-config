# Troubleshooting Guide

This guide provides solutions for common issues and troubleshooting procedures.

## System Issues

### Boot Problems

#### GRUB Issues
```bash
# Reinstall GRUB
nixos-enter
grub-install --target=x86_64-efi --efi-directory=/boot --removable
```

#### ZFS Mount Issues
```bash
# Import pool forcefully
zpool import -f zpool

# Mount all filesystems
zfs mount -a
```

### Configuration Problems

#### Failed System Build
```bash
# Check configuration
nixos-rebuild build --flake .#desktop

# Show trace
nixos-rebuild build --flake .#desktop --show-trace
```

#### Home Manager Issues
```bash
# Build home configuration
home-manager build --flake .#david

# Show trace
home-manager build --flake .#david --show-trace
```

## Storage Issues

### ZFS Problems

#### Pool Status
```bash
# Check pool status
zpool status -v

# Check device errors
zpool clear zpool
```

#### Dataset Issues
```bash
# List datasets
zfs list -t all

# Check properties
zfs get all zpool/root
```

#### Cache Problems
```bash
# Check ARC stats
arc_summary

# Monitor IO
zpool iostat -v 1
```

## Desktop Environment

### Xmonad Issues

#### Recompile Failed
```bash
# Rebuild Xmonad
xmonad --recompile

# Check errors
cat ~/.xmonad/xmonad.errors
```

#### Screen Configuration
```bash
# List outputs
xrandr

# Check config
cat ~/.xmonad/xmonad.hs
```

### Application Problems

#### Neovim Issues
```bash
# Check health
nvim +checkhealth

# Test config
nvim -u NONE
```

#### Program Crashes
```bash
# Check logs
journalctl -xe

# Debug info
coredumpctl list
```

## Network Issues

### Connection Problems

#### Basic Connectivity
```bash
# Check DNS
resolvectl status

# Test connection
ping -c 3 8.8.8.8
```

#### Interface Issues
```bash
# Check interfaces
ip addr show

# Link status
networkctl status
```

## Performance Issues

### System Resources

#### CPU Usage
```bash
# Process view
top
htop

# System stats
vmstat 1
```

#### Memory Issues
```bash
# Memory usage
free -h

# Detailed stats
smem -tk
```

#### Disk Performance
```bash
# IO stats
iostat -x 1

# ZFS performance
zpool iostat -v 1
```

## Recovery Procedures

### System Recovery

1. Boot from Installation Media
```bash
# Mount filesystems
zpool import -f zpool
zfs mount -a
mount /dev/sdX /boot
```

2. Chroot Environment
```bash
nixos-enter
```

3. Repair System
```bash
# Rebuild system
nixos-rebuild switch --flake /path/to/config#desktop
```

### Data Recovery

#### ZFS Snapshots
```bash
# List snapshots
zfs list -t snapshot

# Restore snapshot
zfs rollback zpool/home@backup-20240101
```

#### File Recovery
```bash
# Copy from snapshot
cp /path/to/snapshot/file /recovery/location
```

## Maintenance Tasks

### System Cleanup

#### Nix Store
```bash
# Garbage collection
nix-collect-garbage -d

# Remove old generations
home-manager generations
home-manager remove-generations 30d
```

#### ZFS Maintenance
```bash
# Scrub pools
zpool scrub zpool

# Trim SSDs
zpool trim zpool
```

## Getting Help

### System Information

#### Configuration
```bash
# NixOS version
nixos-version

# System config
cat /etc/nixos/configuration.nix
```

#### Hardware Info
```bash
# PCI devices
lspci -v

# USB devices
lsusb
```

### Debug Information

#### Logs
```bash
# Boot log
journalctl -b

# Service logs
journalctl -u service-name
```

#### Configuration
```bash
# Show current config
nixos-rebuild show-config

# Evaluate config
nix eval
```

## Best Practices

1. Always check logs first
2. Create ZFS snapshots before changes
3. Keep known-good generations
4. Document custom changes
5. Regular system maintenance
6. Backup critical data

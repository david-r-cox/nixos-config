# Troubleshooting Guide

This guide provides solutions for common issues and troubleshooting procedures.

## Common Issues

### System Won't Boot

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

### Storage Issues

#### ZFS Problems

1. **Pool Status**
   ```bash
   zpool status -v
   ```

2. **Dataset Issues**
   ```bash
   zfs list -t all
   ```

3. **Cache Problems**
   ```bash
   arc_summary
   ```

### Desktop Environment

#### Xmonad Issues
```bash
# Rebuild Xmonad
xmonad --recompile

# Check Xmonad log
cat ~/.xmonad/xmonad.errors
```

#### Polybar Problems
```bash
# Start Polybar manually
polybar example

# Check journal
journalctl -u polybar
```

## Diagnostic Procedures

### System Logs
```bash
# View journal
journalctl -xb

# Filter by service
journalctl -u service-name

# Boot messages
journalctl -b
```

### Hardware Info
```bash
# PCI devices
lspci -v

# USB devices
lsusb

# Block devices
lsblk -f
```

### Network Diagnostics
```bash
# Network status
networkctl status

# DNS resolution
resolvectl status

# Connection test
ping -c 3 8.8.8.8
```

## Recovery Procedures

### System Recovery

1. **Boot from Installation Media**
   ```bash
   # Mount filesystems
   zpool import -f zpool
   zfs mount -a
   mount /dev/sdX /boot
   ```

2. **Chroot into System**
   ```bash
   nixos-enter
   ```

3. **Rebuild System**
   ```bash
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

## Performance Issues

### System Resources

1. **CPU Usage**
   ```bash
   top
   htop
   ```

2. **Memory Usage**
   ```bash
   free -h
   vmstat 1
   ```

3. **Disk Usage**
   ```bash
   df -h
   du -sh /*
   ```

### ZFS Performance

1. **Cache Statistics**
   ```bash
   arc_summary
   ```

2. **Pool Performance**
   ```bash
   zpool iostat -v 1
   ```

## Configuration Validation

### Nix Store
```bash
# Verify store
nix store verify --all

# Garbage collection
nix store gc
```

### System Configuration
```bash
# Dry run build
nixos-rebuild dry-build --flake .#desktop

# Show configuration
nixos-rebuild show-config --flake .#desktop
```

## Getting Help

### System Information
```bash
# NixOS version
nixos-version

# System configuration
cat /etc/nixos/configuration.nix

# Hardware configuration
cat /etc/nixos/hardware-configuration.nix
```

### Support Resources

1. [NixOS Discourse](https://discourse.nixos.org/)
2. [NixOS Wiki](https://nixos.wiki/)
3. [GitHub Issues](https://github.com/david-r-cox/nixos-config/issues)

### Debug Information

When reporting issues, include:

1. System configuration
2. Error messages
3. Journal outputs
4. Hardware details
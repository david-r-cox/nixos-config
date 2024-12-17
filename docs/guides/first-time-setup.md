# First-Time Setup Guide

This guide walks through the process of setting up this configuration on a new system.

## Prerequisites

- NixOS installation media
- ZFS support in installation environment
- Internet connection
- SSH key for private repository access

## Installation Steps

### 1. Prepare Installation Media

```bash
# Download NixOS
wget https://nixos.org/releases/nixos/unstable/nixos-unstable/nixos-minimal-x86_64-linux.iso

# Create bootable USB
dd if=nixos-minimal-x86_64-linux.iso of=/dev/sdX bs=4M status=progress
```

### 2. Configure Storage

```bash
# Create ZFS pool
zpool create -f zpool mirror /dev/sda /dev/sdb

# Create datasets
zfs create -o mountpoint=/     zpool/root
zfs create -o mountpoint=/home zpool/home
zfs create -o mountpoint=/nix  zpool/nix
zfs create -o mountpoint=/var  zpool/var

# Enable compression
zfs set compression=zstd zpool
```

### 3. Clone Configurations

```bash
# Clone public config
git clone https://github.com/david-r-cox/nixos-config.git

# Clone private config
git clone git@github.com:david-r-cox/private-nixos-config.git
```

### 4. Initial Build

```bash
# Build system configuration
sudo nixos-rebuild switch --flake .#desktop

# Build home configuration
home-manager switch --flake .
```

### 5. Post-Installation

```bash
# Set up ZFS auto-scrub
systemctl enable zfs-scrub-monthly.timer

# Initialize home directory
hms  # Alias for home-manager switch

# Configure git
git config --global user.name "Your Name"
git config --global user.signingkey "Your Key"
```

## Verification

1. Check ZFS status:
   ```bash
   zpool status
   zfs list
   ```

2. Verify system configuration:
   ```bash
   nixos-version
   home-manager generations
   ```

3. Test editor configuration:
   ```bash
   nvim --version
   nvim +checkhealth
   ```

## Troubleshooting

### Common Issues

1. **ZFS Import Fails**
   ```bash
   zpool import -f zpool
   ```

2. **Build Errors**
   ```bash
   # Show trace
   nixos-rebuild build --show-trace
   ```

3. **Private Config Access**
   ```bash
   # Verify SSH key
   ssh -T git@github.com
   ```

## Next Steps

1. Review the [System Architecture](../system/architecture.md)
2. Configure [Backup Procedures](../maintenance/backup.md)
3. Set up [Development Environment](../development/index.md)

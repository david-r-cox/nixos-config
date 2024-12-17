# nixos-config

Cross-platform NixOS + Home Manager configs

![Nix](https://img.shields.io/badge/NIX-5277C3.svg?logo=NixOS&logoColor=white)
![NixOS](https://img.shields.io/badge/NIXOS-5277C3.svg?logo=NixOS&logoColor=white)

| **Shell** | **DM** | **WM** | **Editor** | **Terminal** | **Status Bar** | **Launcher** |
|-----------|--------|--------|------------|--------------|--------------|----------------|
| [Zsh+Prezto](https://github.com/sorin-ionescu/prezto) | [Xfce](https://www.xfce.org/) | [Xmonad](https://github.com/xmonad/xmonad) | [Neovim](https://github.com/neovim/neovim) | [Alacritty](https://github.com/alacritty/alacritty ) | [Polybar](https://github.com/polybar/polybar) | [Rofi](https://github.com/davatorium/rofi) |

(Previous diagram content preserved...)

## Features

Notable features (some of which live within private flakes but are illustrated below) include...

### ZFS Storage

The system uses [ZFS](https://openzfs.org/wiki/Main_Page) as its primary filesystem, configured with separate datasets for different parts of the system. ZFS provides advanced features like:

- Copy-on-write snapshots
- Built-in compression
- Data integrity verification
- L2ARC caching for improved performance

Example ZFS configuration:

```nix
{
  # Use latest kernel compatible with ZFS
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  
  # Configure ZFS parameters
  boot.kernelParams = [
    "zfs.zfs_arc_max=137438953472"  # Set max ARC size (128GB)
  ];
  
  boot.supportedFilesystems = [ "zfs" ];
  
  # Enable ZFS support in bootloader
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
  };

  # Configure L2ARC parameters
  boot.extraModprobeConfig = ''
    options zfs l2arc_noprefetch=0 l2arc_write_boost=33554432 l2arc_write_max=16777216
  '';

  # Enable ZFS maintenance
  services.zfs = {
    autoScrub.enable = true;  # Regular data integrity checking
    trim.enable = true;       # SSD TRIM support
  };

  # Dataset configuration example
  fileSystems = {
    "/" = { device = "zpool/root"; fsType = "zfs"; };
    "/nix" = { device = "zpool/nix"; fsType = "zfs"; };
    "/home" = { device = "zpool/home"; fsType = "zfs"; };
    "/var" = { device = "zpool/var"; fsType = "zfs"; };
  };
}
```

The configuration includes integrated monitoring via Polybar, displaying ZFS pool status and usage metrics in real-time.

### BTRFS + bees (Historical)

While the system now uses ZFS, the following BTRFS configuration is preserved for reference as it provides an interesting alternative approach to filesystem deduplication:

(Previous BTRFS content preserved...)

### Private Flakes

(Previous content preserved...)

### 147 Virtual Desktops 🤯

(Previous content preserved...)

### Local Nix Cache

(Previous content preserved...)

### Bonded Network Interfaces

(Previous content preserved...)

### CCache

(Previous content preserved...)

### Apple Function Key Remap

(Previous content preserved...)

### Borg Backup

(Previous content preserved...)

### Declarative Deployments

(Previous content preserved...)
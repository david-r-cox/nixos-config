# Adding a New Device

This guide covers the process of adding a new device to your NixOS configuration.

## Prerequisites

- Working NixOS installation
- Access to private configuration repository
- SSH key setup
- Basic understanding of hardware details

## Process

### 1. Hardware Configuration

```bash
# Generate hardware configuration
nixos-generate-config --dir ./nixos

# Review and customize
vim nixos/hardware-configuration.nix
```

### 2. Create Device Profile

```nix
# devices/newdevice/default.nix
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/profiles/desktop.nix
  ];

  # Device-specific settings
  networking.hostName = "newdevice";
  
  # Hardware-specific tuning
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
```

### 3. Add to Flake

```nix
{
  nixosConfigurations = {
    newdevice = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./devices/newdevice
        home-manager.nixosModules.home-manager
        {
          home-manager.users.david = import ./home;
        }
      ];
    };
  };
}
```

### 4. Configure Private Settings

```nix
# private-nixos-config/devices/newdevice/default.nix
{
  # Hardware-specific settings
  hardware.cpu.intel.enable = true;
  
  # Network configuration
  networking = {
    interfaces = {
      enp5s0.useDHCP = true;
    };
  };
  
  # Device-specific secrets
  age.secrets = {
    deviceKey = {
      file = ../secrets/newdevice.age;
      path = "/etc/secrets/device";
    };
  };
}
```

### 5. Initial Deployment

```bash
# Build configuration
sudo nixos-rebuild build --flake .#newdevice

# Deploy
sudo nixos-rebuild switch --flake .#newdevice
```

## Verification

### 1. System Check

```bash
# Verify system
nixos-version
hostnamectl

# Check ZFS
zpool status
zfs list
```

### 2. Service Check

```bash
# Check critical services
systemctl status

# Check logs
journalctl -xb
```

### 3. Network Check

```bash
# Verify networking
ping -c 3 8.8.8.8
dig nixos.org
```

## Common Customizations

### 1. Display Configuration

```nix
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm.enable = true;
  };
}
```

### 2. Power Management

```nix
{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };
}
```

### 3. Storage Configuration

```nix
{
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
    };
    trim.enable = true;
  };
}
```

## Troubleshooting

### Common Issues

1. **Hardware Detection**
   ```bash
   # List PCI devices
   lspci
   # List USB devices
   lsusb
   ```

2. **Boot Issues**
   ```bash
   # Check boot logs
   journalctl -b
   ```

3. **Configuration Problems**
   ```bash
   # Build with trace
   nixos-rebuild build --flake .#newdevice --show-trace
   ```

## Best Practices

1. Start with minimal configuration
2. Add features incrementally
3. Test each major change
4. Document device-specific quirks
5. Keep hardware configuration separate
6. Regular backup testing

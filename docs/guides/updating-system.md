# System Update Guide

This guide covers the process of updating your system safely and effectively.

## Regular Updates

### 1. Update Flake Inputs

```bash
# Update all inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs
```

### 2. Build and Test

```bash
# Test system build
sudo nixos-rebuild build --flake .#desktop

# Test home-manager build
home-manager build --flake .
```

### 3. Apply Updates

```bash
# Update system
sudo nixos-rebuild switch --flake .#desktop

# Update home configuration
hms  # Alias for home-manager switch
```

### 4. Verify

```bash
# Check system version
nixos-version

# Check home-manager generation
home-manager generations
```

## Major Version Updates

### 1. Preparation

- Create ZFS snapshot
- Review release notes
- Check for breaking changes

### 2. Update Process

```bash
# Update to specific NixOS version
nix flake lock --update-input nixpkgs --override-input nixpkgs github:NixOS/nixpkgs/nixos-23.11

# Build and test
sudo nixos-rebuild build --flake .#desktop

# Apply update
sudo nixos-rebuild switch --flake .#desktop
```

### 3. Post-Update

- Verify all services
- Check logs for errors
- Test critical applications

## Rollback Procedures

### Quick Rollback

```bash
# System rollback
sudo nixos-rebuild switch --rollback

# Home-manager rollback
home-manager generations
home-manager switch --flake .#david/<generation-number>
```

### ZFS Snapshot Rollback

```bash
# List snapshots
zfs list -t snapshot

# Rollback if needed
zfs rollback zpool/root@pre-update
```

## Maintenance

### Garbage Collection

```bash
# Remove old generations
nix-collect-garbage -d

# Deep clean
nix-collect-garbage --delete-old
```

### Storage Management

```bash
# Check disk usage
nix path-info -S /run/current-system
du -sh /nix/store/

# Clean store
nix store gc
```

## Troubleshooting

### Common Issues

1. **Build Failures**
   ```bash
   # Show trace
   nixos-rebuild build --show-trace
   ```

2. **Dependency Conflicts**
   ```bash
   # Check dependencies
   nix why-depends /run/current-system package
   ```

3. **Service Failures**
   ```bash
   # Check logs
   journalctl -xb
   ```

## Best Practices

1. Always create a ZFS snapshot before updates
2. Test builds before switching
3. Keep known-good generations
4. Monitor system after updates
5. Regular garbage collection

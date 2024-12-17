# NixOS Configuration Documentation

Welcome to the documentation for this NixOS configuration framework. This documentation provides comprehensive information about the system setup, configuration patterns, and maintenance procedures.

## Overview

This NixOS configuration implements a modular, declarative system configuration with the following key features:

- Home Manager integration for user environment management
- ZFS-based storage with advanced dataset configuration
- Xmonad-based desktop environment with extensive customization
- Polybar system monitoring with ZFS integration
- Development environment optimizations
- Private configuration management via flakes

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/david-r-cox/nixos-config.git
   ```

2. Initialize the private configuration:
   ```bash
   git clone git@github.com:david-r-cox/private-nixos-config.git
   ```

3. Apply the configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#desktop
   ```

## Documentation Sections

### System Configuration
- [System Architecture](./system/architecture.md)
- [Storage Configuration](./system/storage.md)
- [Network Setup](./system/network.md)
- [Security Policies](./system/security.md)

### User Environment
- [Desktop Environment](./desktop/index.md)
- [Development Tools](./development/index.md)
- [Application Configuration](./applications/index.md)

### Maintenance
- [Backup Procedures](./maintenance/backup.md)
- [System Updates](./maintenance/updates.md)
- [Troubleshooting](./maintenance/troubleshooting.md)

### Development
- [Contributing Guidelines](./development/contributing.md)
- [Code Style](./development/style.md)
- [Testing](./development/testing.md)

### Reference
- [Configuration Options](./reference/options.md)
- [Custom Modules](./reference/modules.md)
- [Private Configuration](./reference/private-config.md)

## Getting Help

If you encounter issues or have questions:

1. Check the [Troubleshooting Guide](./maintenance/troubleshooting.md)
2. Search existing [GitHub Issues](https://github.com/david-r-cox/nixos-config/issues)
3. Create a new issue if needed

## Contributing

Contributions are welcome! Please see our [Contributing Guidelines](./development/contributing.md) for details on:

- Code style and standards
- Commit message format
- Testing requirements
- Pull request process

## License

This configuration is distributed under the MIT License. See the [LICENSE](../LICENSE) file for details.
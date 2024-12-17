# Contributing Guidelines

This document outlines the process for contributing to this NixOS configuration framework.

## Code Style

### Nix Formatting

All Nix code must follow the standard formatting rules:

- Use 2-space indentation
- Format with `nixfmt` or `alejandra`
- Follow the [Nixpkgs contribution guidelines](https://github.com/NixOS/nixpkgs/blob/master/CONTRIBUTING.md)

Example:
```nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    enable = lib.mkEnableOption "feature";
  };

  config = lib.mkIf config.enable {
    # Configuration here
  };
}
```

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```plaintext
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style changes
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding tests
- `build`: Build system changes
- `ci`: CI configuration changes
- `chore`: Other changes

Examples:
```plaintext
feat(neovim): add custom syntax highlighting for Nix
fix(zfs): correct L2ARC cache size configuration
docs(readme): update installation instructions
```

## Development Workflow

1. **Fork and Clone**
   ```bash
   git clone https://github.com/your-username/nixos-config.git
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feat/new-feature
   ```

3. **Make Changes**
   - Follow code style guidelines
   - Add tests if applicable
   - Update documentation

4. **Test Changes**
   ```bash
   # Build configuration
   nixos-rebuild build --flake .#desktop
   
   # Run tests
   nix flake check
   ```

5. **Commit Changes**
   ```bash
   git add .
   git commit -m "feat(scope): description"
   ```

6. **Submit Pull Request**
   - Use the PR template
   - Link related issues
   - Describe changes thoroughly

## Testing

### Shell Aliases

The following shell aliases are available for common operations:

- `hms`: Build and switch home-manager configuration (`home-manager switch --flake . --cores 48 --builders 12`)
- `hmsr`: Build and switch using remote configuration
- `nxs`: Build and switch system configuration
- `nxsr`: Build and switch system configuration using remote
- `hme`: Edit home-manager configuration
- `nxe`: Edit system configuration

### Required Tests

1. **Configuration Build**
   ```bash
   nixos-rebuild build --flake .#desktop
   ```

2. **Flake Check**
   ```bash
   nix flake check
   ```

3. **Format Check**
   ```bash
   nixfmt --check .
   ```

### Optional Tests

1. **Home Manager Build**
   ```bash
   home-manager build --flake .#david
   ```

2. **VM Test**
   ```bash
   nixos-rebuild build-vm --flake .#desktop
   ```

## Documentation

### Required Documentation

1. **Code Comments**
   - Document non-obvious configurations
   - Explain complex expressions
   - Note dependencies and requirements

2. **Module Documentation**
   - Document options
   - Provide usage examples
   - List dependencies

3. **Update Existing Docs**
   - Update README if needed
   - Modify relevant documentation
   - Add new documentation files

## Review Process

1. **Initial Review**
   - Code style check
   - Documentation review
   - Test verification

2. **Technical Review**
   - Configuration logic
   - Performance impact
   - Security implications

3. **Final Review**
   - Integration testing
   - Documentation completeness
   - Merge approval

## Getting Help

1. **Documentation**
   - Check existing documentation
   - Review similar changes
   - Search closed issues

2. **Community**
   - Ask in GitHub Issues
   - Join relevant discussions
   - Seek maintainer input

3. **Resources**
   - [NixOS Manual](https://nixos.org/manual/nixos/stable/)
   - [Home Manager Manual](https://nix-community.github.io/home-manager/)
   - [Nix Reference](https://nixos.org/manual/nix/stable/)
# 4. Private Configuration Separation

Date: 2024-03-19

## Status

Accepted

## Context

We need to manage sensitive configuration details while maintaining:
- Security of private information
- Ability to share public configurations
- Easy system replication
- Separation of concerns

## Decision

We will use a separate private flake for sensitive configurations:
- Hardware-specific details
- Network configurations
- Credentials and secrets
- Machine-specific optimizations

The private configuration will be:
- Stored in a separate repository
- Referenced via SSH URL in flake inputs
- Merged with public configuration at build time

## Consequences

### Positive
- Clear separation of sensitive data
- Ability to share public config
- Flexible per-machine configuration
- Secure credential management

### Negative
- More complex initial setup
- Need to manage multiple repositories
- Requires SSH access for builds

### Mitigations
- Clear documentation of setup process
- Automated build validation
- Local development procedures

# Coding Style Guide

This document outlines the coding standards and best practices for this configuration.

## Nix Style

### 1. File Organization

Files should be organized in a logical hierarchy:
```
.
├── lib/                # Shared functions and types
├── modules/            # System modules
├── profiles/           # System profiles
└── home-manager/       # User environment
```

### 2. Module Structure

Each module should follow this structure:
```nix
{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.<module>;
in {
  imports = [
    # Related modules
  ];

  options.mySystem.<module> = {
    enable = lib.mkEnableOption "<module> configuration";
    
    # Other options...
  };

  config = lib.mkIf cfg.enable {
    # Configuration...
  };
}
```

### 3. Naming Conventions

#### Variables and Functions
- Use camelCase for variables and functions
- Use descriptive names that indicate purpose
```nix
# Good
let
  userConfig = { ... };
  makeUserConfig = name: { ... };
in
```

#### Options
- Use kebab-case for option names
- Group related options under meaningful prefixes
```nix
options.mySystem.service-name = {
  enable = lib.mkEnableOption "service description";
  max-connections = lib.mkOption { ... };
};
```

#### Files
- Use kebab-case for file names
- Use `.nix` extension
- Use descriptive names
```
user-management.nix
zfs-configuration.nix
backup-service.nix
```

### 4. Comments and Documentation

#### Module Documentation
```nix
# Module: Service Name
#
# This module provides configuration for...
#
# Options:
#   enable - Enable the service
#   port   - Service port number
```

#### Complex Logic
```nix
# Transform the input list into a structured format
# Input: ["a" "b"]
# Output: { a = true; b = true; }
let
  transformList = list: 
    lib.listToAttrs (map (x: { name = x; value = true; }) list);
in
```

### 5. Type Safety

Always use typed options:
```nix
{
  port = lib.mkOption {
    type = lib.types.port;
    example = 8080;
    description = "Port number";
  };

  name = lib.mkOption {
    type = lib.types.str;
    description = "Service name";
  };
}
```

### 6. Error Handling

Use assertions for validation:
```nix
{
  assertions = [
    {
      assertion = cfg.port > 1024;
      message = "Port must be > 1024";
    }
  ];
}
```

### 7. Code Organization

#### Option Grouping
Group related options together:
```nix
{
  database = {
    enable = lib.mkEnableOption "database";
    port = lib.mkOption { ... };
    user = lib.mkOption { ... };
  };
  
  security = {
    enable = lib.mkEnableOption "security";
    ssl = lib.mkOption { ... };
    firewall = lib.mkOption { ... };
  };
}
```

#### Configuration Grouping
Group related configurations:
```nix
config = lib.mkIf cfg.enable {
  # Service configuration
  services.example = {
    enable = true;
    port = cfg.port;
  };

  # Security settings
  security.example = {
    enable = cfg.security.enable;
    cert = cfg.security.cert;
  };

  # System configuration
  systemd.services.example = {
    description = "Example Service";
    wantedBy = [ "multi-user.target" ];
  };
};
```

### 8. Best Practices

1. **Use Type-Safe Options**
```nix
# Good
option = lib.mkOption {
  type = lib.types.str;
  description = "Description";
};

# Bad
option = lib.mkOption {
  type = lib.types.anything;
};
```

2. **Provide Clear Documentation**
```nix
# Good
port = lib.mkOption {
  type = lib.types.port;
  default = 8080;
  description = ''
    The port number for the service.
    Must be > 1024 for non-root usage.
  '';
  example = 8080;
};

# Bad
port = lib.mkOption {
  type = lib.types.int;
};
```

3. **Use Meaningful Defaults**
```nix
# Good
{
  enable = lib.mkEnableOption "service";
  logLevel = lib.mkOption {
    type = lib.types.enum [ "debug" "info" "warn" "error" ];
    default = "info";
  };
}

# Bad
{
  logLevel = lib.mkOption {
    type = lib.types.str;
    default = "";
  };
}
```

4. **Validate Input**
```nix
# Good
{
  assertions = [
    {
      assertion = cfg.maxConnections >= 1;
      message = "maxConnections must be >= 1";
    }
  ];
}

# Bad
{
  maxConnections = cfg.input;  # No validation
}
```

5. **Use Common Functions**
```nix
# Good
let
  inherit (lib.strings) concatStringsSep;
  inherit (lib.lists) flatten;
in
  concatStringsSep "," (flatten list)

# Bad
list.join(",")  # Not using standard functions
```

6. **Consistent Formatting**
```nix
# Good
{
  services.example = {
    enable = true;
    port = 8080;
    user = "service";
  };
}

# Bad
{services.example=
  {enable=true;
   port=8080;user="service";};}
```

### 9. Testing

1. **Configuration Testing**
```nix
{
  tests = {
    basic = makeTest {
      nodes.machine = { ... }: {
        imports = [ ./module.nix ];
        config = {
          # Test configuration
        };
      };
      
      testScript = ''
        # Test script
      '';
    };
  };
}
```

2. **Type Testing**
```nix
{
  options.example = {
    value = lib.mkOption {
      type = lib.types.addCheck lib.types.int (x: x > 0);
      description = "Must be positive";
    };
  };
}
```

### 10. Performance

1. **Lazy Evaluation**
```nix
# Good
let
  expensive = import ./expensive.nix;
in {
  value = lib.mkIf condition expensive;
}

# Bad
let
  expensive = import ./expensive.nix;
in {
  value = if condition then expensive else null;
}
```

2. **Resource Usage**
```nix
# Good
{
  services.example = {
    maxMemory = "256M";
    maxCpu = 2;
  };
}

# Bad
{
  services.example = {
    unlimitedResources = true;
  };
}
```
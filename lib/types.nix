{ lib }:

{
  # Common type definitions for use across modules
  port = lib.types.addCheck lib.types.int (p: p > 0 && p < 65536);
  
  userConfig = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Username";
      };
      
      fullName = lib.mkOption {
        type = lib.types.str;
        description = "Full name";
      };
      
      email = lib.mkOption {
        type = lib.types.str;
        description = "Email address";
      };
      
      initialPassword = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Initial password (should be changed)";
      };
      
      groups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Group memberships";
      };
    };
  };

  filePermissions = lib.types.submodule {
    options = {
      user = lib.mkOption {
        type = lib.types.str;
        description = "File owner";
      };
      
      group = lib.mkOption {
        type = lib.types.str;
        description = "File group";
      };
      
      mode = lib.mkOption {
        type = lib.types.str;
        description = "File permissions (e.g., '0644')";
      };
    };
  };

  backupConfig = lib.types.submodule {
    options = {
      paths = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Paths to backup";
      };
      
      exclude = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Paths to exclude";
      };
      
      schedule = lib.mkOption {
        type = lib.types.str;
        description = "Backup schedule (systemd calendar format)";
      };
      
      retention = lib.mkOption {
        type = lib.types.submodule {
          options = {
            daily = lib.mkOption {
              type = lib.types.int;
              default = 7;
              description = "Days to keep backups";
            };
            weekly = lib.mkOption {
              type = lib.types.int;
              default = 4;
              description = "Weeks to keep backups";
            };
            monthly = lib.mkOption {
              type = lib.types.int;
              default = 6;
              description = "Months to keep backups";
            };
          };
        };
        default = {};
        description = "Backup retention policy";
      };
    };
  };
}

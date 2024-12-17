{ config, lib, pkgs, ... }:

{
  options = {
    mySystem.users = {
      enable = lib.mkEnableOption "user management";
      
      primaryUser = lib.mkOption {
        type = lib.types.submodule {
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
              type = lib.types.str;
              default = "changeme";
              description = "Initial password (should be changed)";
            };
            
            extraGroups = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ "wheel" "networkmanager" ];
              description = "Additional groups";
            };
          };
        };
        description = "Primary user configuration";
      };
    };
  };

  config = lib.mkIf config.mySystem.users.enable {
    users.users.${config.mySystem.users.primaryUser.name} = {
      isNormalUser = true;
      inherit (config.mySystem.users.primaryUser) initialPassword;
      extraGroups = config.mySystem.users.primaryUser.extraGroups;
      openssh.authorizedKeys.keys = [
        # Add SSH keys here
      ];
    };

    # User environment
    programs.zsh.enable = true;
    users.users.${config.mySystem.users.primaryUser.name}.shell = pkgs.zsh;
  };
}

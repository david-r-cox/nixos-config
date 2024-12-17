{ config, lib, pkgs, ... }:

{
  options.mySystem.security.secrets = {
    enable = lib.mkEnableOption "secrets management";

    directory = lib.mkOption {
      type = lib.types.path;
      default = /var/lib/secrets;
      description = "Directory for secret storage";
    };

    age = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable agenix for secret management";
      };

      identityPaths = lib.mkOption {
        type = lib.types.listOf lib.types.path;
        default = [];
        description = "Paths to age identity files";
      };
    };
  };

  config = lib.mkIf config.mySystem.security.secrets.enable {
    age = lib.mkIf config.mySystem.security.secrets.age.enable {
      identityPaths = config.mySystem.security.secrets.age.identityPaths;
    };

    # Ensure secrets directory exists
    system.activationScripts.secretsDir = ''
      mkdir -p ${config.mySystem.security.secrets.directory}
      chmod 750 ${config.mySystem.security.secrets.directory}
    '';

    # Install agenix if enabled
    environment.systemPackages = lib.mkIf config.mySystem.security.secrets.age.enable [
      pkgs.age
      pkgs.rage
      pkgs.agenix
    ];
  };
}

{ config, lib, pkgs, ... }:

{
  imports = [
    ./zfs.nix
  ];

  options.mySystem.services = {
    enable = lib.mkEnableOption "system services";
  };

  config = lib.mkIf config.mySystem.services.enable {
    # Common service configuration
    services = {
      # Basic system services
      openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
        };
      };

      # Time synchronization
      timesyncd.enable = true;
    };
  };
}

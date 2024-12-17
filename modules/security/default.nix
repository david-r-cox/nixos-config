{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardening.nix
    ./secrets.nix
  ];

  options.mySystem.security = {
    enable = lib.mkEnableOption "security configuration";
  };

  config = lib.mkIf config.mySystem.security.enable {
    # Basic security configuration
    security = {
      sudo.enable = true;
      sudo.wheelNeedsPassword = true;
      
      polkit.enable = true;
      
      protectKernelImage = true;
      
      auditd.enable = true;
      
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
      };
    };

    # Firewall
    networking.firewall = {
      enable = true;
      allowPing = false;
      logRefusedConnections = true;
    };
  };
}

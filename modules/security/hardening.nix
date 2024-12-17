{ config, lib, pkgs, ... }:

{
  options.mySystem.security.hardening = {
    enable = lib.mkEnableOption "system hardening";

    kernel = {
      sysrq = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable SysRq key";
      };

      unprivilegedBPF = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Allow unprivileged BPF";
      };
    };

    network = {
      tcp_syncookies = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable TCP SYN cookies";
      };

      ipv6 = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable IPv6";
      };
    };
  };

  config = lib.mkIf config.mySystem.security.hardening.enable {
    # Kernel hardening
    boot.kernel.sysctl = {
      # Restrict SysRq
      "kernel.sysrq" = lib.mkIf (!config.mySystem.security.hardening.kernel.sysrq) 0;

      # Restrict BPF
      "kernel.unprivileged_bpf_disabled" =
        lib.mkIf (!config.mySystem.security.hardening.kernel.unprivilegedBPF) 1;

      # Network hardening
      "net.ipv4.tcp_syncookies" =
        lib.mkIf config.mySystem.security.hardening.network.tcp_syncookies 1;

      # Core dumps
      "kernel.core_pattern" = "|/run/current-system/sw/bin/false";
      "fs.suid_dumpable" = 0;

      # Restict ptrace
      "kernel.yama.ptrace_scope" = 2;

      # Protect against hardlinks and symlinks
      "fs.protected_hardlinks" = 1;
      "fs.protected_symlinks" = 1;

      # Memory protections
      "kernel.kptr_restrict" = 2;
      "vm.mmap_min_addr" = 65536;
      "kernel.kexec_load_disabled" = 1;
    };

    # Network hardening
    networking = {
      enableIPv6 = config.mySystem.security.hardening.network.ipv6;
      firewall.allowedTCPPorts = [ ];
      firewall.allowedUDPPorts = [ ];
    };

    # Additional security measures
    security = {
      protectKernelImage = true;
      lockKernelModules = true;
      
      audit = {
        enable = true;
        rules = [
          "-a exit,always -F arch=b64 -S execve"
        ];
      };

      apparmor.killUnconfinedConfinables = true;
    };

    # Restrict console access
    services.physlock = {
      enable = true;
      allowAnyUser = false;
    };

    # Secure boot (if supported)
    boot.bootspec.enable = true;
  };
}

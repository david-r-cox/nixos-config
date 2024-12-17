{ config, lib, pkgs, ... }:

{
  options = {
    mySystem.hardware = {
      enable = lib.mkEnableOption "hardware configuration";
      
      cpu = {
        vendor = lib.mkOption {
          type = lib.types.enum [ "intel" "amd" ];
          description = "CPU vendor";
        };
        
        enableTurboBoost = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable CPU Turbo Boost";
        };
      };
      
      gpu = {
        type = lib.mkOption {
          type = lib.types.enum [ "nvidia" "amd" "intel" "hybrid" ];
          description = "GPU configuration type";
        };
        
        prime = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable NVIDIA PRIME for hybrid graphics";
        };
      };
    };
  };

  config = lib.mkIf config.mySystem.hardware.enable {
    hardware.cpu = {
      intel.updateMicrocode = config.mySystem.hardware.cpu.vendor == "intel";
      amd.updateMicrocode = config.mySystem.hardware.cpu.vendor == "amd";
    };

    services.xserver.videoDrivers = lib.mkMerge [
      (lib.mkIf (config.mySystem.hardware.gpu.type == "nvidia") [ "nvidia" ])
      (lib.mkIf (config.mySystem.hardware.gpu.type == "amd") [ "amdgpu" ])
      (lib.mkIf (config.mySystem.hardware.gpu.type == "intel") [ "modesetting" ])
      (lib.mkIf (config.mySystem.hardware.gpu.type == "hybrid") [ "nvidia" "modesetting" ])
    ];

    hardware.nvidia = lib.mkIf (config.mySystem.hardware.gpu.type == "nvidia" || config.mySystem.hardware.gpu.type == "hybrid") {
      prime = {
        enable = config.mySystem.hardware.gpu.prime;
        # Configure PRIME specifics here
      };
      powerManagement = {
        enable = true;
        finegrained = true;
      };
    };
  };
}

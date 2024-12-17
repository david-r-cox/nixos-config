{ lib }:

rec {
  # Option creation helpers
  mkEnableOption' = name: description: lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = description;
    example = true;
  };

  mkPackageOption = pkgs: name: {
    description ? "The ${name} package to use.",
    default ? pkgs.${name},
    example ? null
  }: lib.mkOption {
    type = lib.types.package;
    inherit default description;
    example = if example != null then example else lib.literalExpression "pkgs.${name}";
  };

  mkPortOption = port: description: lib.mkOption {
    type = lib.types.port;
    inherit description;
    default = port;
    example = port;
  };

  # Service options
  mkServiceOptions = name: extra: lib.recursiveUpdate {
    enable = mkEnableOption' name "Enable the ${name} service";
    package = lib.mkOption {
      type = lib.types.package;
      description = "The package to use for ${name}";
    };
    user = lib.mkOption {
      type = lib.types.str;
      default = name;
      description = "User account under which ${name} runs";
    };
    group = lib.mkOption {
      type = lib.types.str;
      default = name;
      description = "Group under which ${name} runs";
    };
    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/${name}";
      description = "${name} data directory";
    };
  } extra;

  # Common options
  mkCommonOptions = {
    logLevel = lib.mkOption {
      type = lib.types.enum [ "debug" "info" "warn" "error" ];
      default = "info";
      description = "Logging level";
    };
    
    configFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to configuration file";
    };
    
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open required firewall ports";
    };
  };
}

{ config, lib, pkgs, ... }:

{
  options.mySystem.maintenance.monitoring = {
    enable = lib.mkEnableOption "system monitoring";

    prometheus = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Prometheus monitoring";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 9090;
        description = "Prometheus port";
      };
    };

    nodeExporter = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Node Exporter";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 9100;
        description = "Node Exporter port";
      };
    };

    grafana = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Grafana";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 3000;
        description = "Grafana port";
      };
    };
  };

  config = lib.mkIf config.mySystem.maintenance.monitoring.enable {
    # Prometheus
    services.prometheus = lib.mkIf config.mySystem.maintenance.monitoring.prometheus.enable {
      enable = true;
      port = config.mySystem.maintenance.monitoring.prometheus.port;
      
      exporters = {
        node = lib.mkIf config.mySystem.maintenance.monitoring.nodeExporter.enable {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = config.mySystem.maintenance.monitoring.nodeExporter.port;
        };
      };

      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [{
            targets = [ "localhost:${toString config.mySystem.maintenance.monitoring.nodeExporter.port}" ];
          }];
        }
      ];
    };

    # Grafana
    services.grafana = lib.mkIf config.mySystem.maintenance.monitoring.grafana.enable {
      enable = true;
      settings = {
        server = {
          http_port = config.mySystem.maintenance.monitoring.grafana.port;
          http_addr = "127.0.0.1";
        };
      };
    };

    # Monitoring tools
    environment.systemPackages = with pkgs; [
      prometheus
      grafana
      telegraf
    ];

    # Firewall
    networking.firewall = {
      allowedTCPPorts = lib.mkMerge [
        (lib.mkIf config.mySystem.maintenance.monitoring.prometheus.enable
          [ config.mySystem.maintenance.monitoring.prometheus.port ])
        (lib.mkIf config.mySystem.maintenance.monitoring.nodeExporter.enable
          [ config.mySystem.maintenance.monitoring.nodeExporter.port ])
        (lib.mkIf config.mySystem.maintenance.monitoring.grafana.enable
          [ config.mySystem.maintenance.monitoring.grafana.port ])
      ];
    };
  };
}

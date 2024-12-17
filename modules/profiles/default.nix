{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop.nix
  ];

  options.mySystem.profiles = {
    enable = lib.mkEnableOption "system profiles";
  };

  config = lib.mkIf config.mySystem.profiles.enable {
    # Common profile settings
    environment.systemPackages = with pkgs; [
      git
      htop
      ripgrep
      tree
    ];
  };
}

{
  description = "https://github.com/david-r-cox/nixos-config";

  inputs = rec {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cargo2nix.url = "github:cargo2nix/cargo2nix";
    flake-utils.url = "github:numtide/flake-utils";
    napali.url = "https://flakehub.com/f/integrated-reasoning/napali/*.tar.gz";
    nix-base.url = "git+ssh://git@gitlab.com/integrated-reasoning/nix-base";
    nix-search-cli.url = "github:peterldowns/nix-search-cli";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    private.url = "git+ssh://git@github.com/david-r-cox/private-nixos-config";
  };

  outputs =
    { self
    , cargo2nix
    , flake-utils
    , home-manager
    , napali
    , nix-base
    , nix-search-cli
    , nixpkgs
    , private
    , ...
    } @inputs:
    flake-utils.lib.eachDefaultSystem (system:
    let
      inherit (pkgs.stdenv) isLinux;
      inherit (pkgs.lib) optionals;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = false;
      };
      commonPackages = [
        nix-search-cli.packages.${system}.default
        cargo2nix.packages.${system}.default
        napali
      ];
      platformPackages = {
        "x86_64-linux" = [
          nix-base.packages.x86_64-linux.pyscipopt
        ];
        "aarch64-linux" = [ ];
        "aarch64-darwin" = [ ];
      };
    in
    {
      nixConfig = {
        extra-substituters = [ ];
        extra-trusted-public-keys = [ ];
      } // private.nixConfig;
      packages = {
        default = home-manager.defaultPackage.${system};
        homeConfigurations = {
          "david" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              {
                home.packages = commonPackages
                  ++ platformPackages.${system};
              }
              ./home-manager/home.nix
            ];
          };
        };
      };
      nixosConfigurations = { }
        // optionals isLinux private.nixosConfigurations;
      apps = { }
        // optionals isLinux private.apps;
    });
}

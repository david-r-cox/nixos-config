{
  description = "https://github.com/david-r-cox/nixos-config";

  inputs = rec {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #cargo2nix.url = "github:cargo2nix/cargo2nix";
    flake-utils.url = "github:numtide/flake-utils";
    napali.url = "https://flakehub.com/f/integrated-reasoning/napali/*.tar.gz";
    nix-search-cli.url = "github:peterldowns/nix-search-cli";
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixpkgs-unstable";
    irnixpkgs.url = "github:integrated-reasoning/nixpkgs/magenta.nvim";
    private.url = "git+ssh://git@github.com/david-r-cox/private-nixos-config";
    nix-fast-build.url = "github:Mic92/nix-fast-build";

  };

  outputs =
    {
      self,
      #, cargo2nix
      flake-utils,
      home-manager,
      napali,
      nix-search-cli,
      nixpkgs,
      irnixpkgs,
      private,
      nix-fast-build,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        inherit (pkgs.stdenv) isLinux;
        inherit (pkgs.lib) optionals;
        irpkgs = import irnixpkgs {
          inherit system;
          config.allowUnfree = false;
        };
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = false;
          config.allowUnfreePredicate =
            pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              #"google-chrome"
            ];
        };
        pkgsWithPlugin = pkgs.extend (
          _: prev: {
            vimPlugins = prev.vimPlugins // {
              inherit (irpkgs.vimPlugins) magenta-nvim;

              telescope-grouped-keymaps-nvim = pkgs.vimUtils.buildVimPlugin {
                pname = "telescope-grouped-keymaps.nvim";
                version = "2025-06-28";
                src = pkgs.fetchFromGitHub {
                  owner = "JulianNymark";
                  repo = "telescope-grouped-keymaps.nvim";
                  rev = "517a407c7f36f1e36da7e97959b56d93114ce48d";
                  sha256 = "sha256-kmGGFUo3+pIakBGgJ3e/vzsYkxEDLOooIY9CquUo/ao=";
                };
              };
            };
          }
        );
        commonPackages = [
          nix-search-cli.packages.${system}.default
          nix-fast-build.packages.${system}.default
          #cargo2nix.packages.${system}.default
          napali
        ];
        platformPackages = {
          "x86_64-linux" = [ ];
          "x86_64-darwin" = [ ];
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
              pkgs = pkgsWithPlugin;
              extraSpecialArgs = {
                isCorp = true;
              };
              modules = [
                {
                  home.packages = commonPackages ++ platformPackages.${system};
                }
                ./home-manager/home.nix
              ];
            };
          };
        };
        nixosConfigurations = { } // optionals isLinux private.nixosConfigurations;
        apps = { } // optionals isLinux private.apps;
      }
    );
}

# nixos-config
Cross-platform NixOS + Home Manager configs

```mermaid
stateDiagram-v2
  direction LR
  state Inputs {
    state Utilities {
      Cargo2Nix
      NixSearchCli
      Napali
      Cargo2Nix --> CommonPackages
      Napali --> CommonPackages
      NixSearchCli --> CommonPackages
    }
    NixBase
    NixBase --> PlatformPackages
    note left of NixBase
      gitlab:integrated-reasoning
    end note
    Private
    Private --> Apps
    Private --> NixConfig
    Private --> NixosConfigurations
    note left of Private
      secret
    end note
    FlakeUtils
    HomeManager
    Nixpkgs
    Nixpkgs --> Packages
    Nixpkgs --> Programs
  }
  HomeManager --> Home
  state Home {
    CommonPackages
    state PlatformPackages {
      state aarch64 {
        Darwin
        Linux
      }
      state x86_64-Linux{
        Pyscipopt
      }
    }
    CommonPackages --> Configuration
    PlatformPackages --> Configuration
    state Configuration {
      Dotfiles
      Dotfiles --> Polybar
      ServiceBouncer --> Polybar
      Dotfiles --> wd
      state Packages {
        Btop
        Comma
        Feh
        Feh --> WallpaperSwitcher
        Ghc
        Ghc --> Xmonad
        Polybar
      }
      Xdg
      Xdg --> Neovim
      state ColorSchemes {
        AyuDark
        Catppuccin
        Kanagawa
        TokyoNightMoon
      }
      ColorSchemes --> Alacritty
      ColorSchemes --> Neovim
      state Programs {
        Alacritty
        Git
        Git --> Neovim
        state Neovim {
          ALE
          LuaLine
          NvimTree
          Treesitter
          Telescope
        }
        Polybar --> Xmonad
        state Xmonad {
          GridSelect
          TreeSelect
        }
        state Zsh {
          Prezto
          wd
        }
        Rofi
        Rofi --> Xmonad
        Xmonad --> Alacritty
        Xmonad --> Neovim
        Alacritty --> Zsh
      }
      state Systemd {
        WallpaperSwitcher
        ServiceBouncer
        ServiceBouncer --> WallpaperSwitcher
      }
    }
  }
  Inputs --> Outputs
  FlakeUtils --> Outputs
  Home --> HomeConfigurations
  state Outputs {
    HomeConfigurations
    HomeConfigurations --> NixosConfigurations
    state NixosConfigurations {
      Cache
      Desktop
      MacBookAir
    }
    NixConfig
    NixosConfigurations --> Apps
    state Apps {
      Deploy
    }
  }
```

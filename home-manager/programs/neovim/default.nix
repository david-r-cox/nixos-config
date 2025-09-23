{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = true;
    defaultEditor = true;
    extraConfig = builtins.readFile ./extraConfig.vim;
    #extraLuaConfig = builtins.readFile (./extraLuaConfig.lua);
    plugins = import ./plugins { inherit (pkgs) vimPlugins; };
    coc.enable = true;
    coc.settings = {
      suggest = {
        noselect = true;
        enablePreview = true;
        enablePreselect = true;
        disableKind = true;
      };
      languageserver = {
        haskell = {
          command = "haskell-language-server-wrapper";
          args = [ "--lsp" ];
          rootPatterns = [
            "*.cabal"
            "stack.yaml"
            "cabal.project"
            "package.yaml"
            "hie.yaml"
          ];
          filetypes = [
            "haskell"
            "lhaskell"
          ];
          settings = {
            haskell = {
              checkParents = "CheckOnSave";
              checkProject = true;
              maxCompletions = 40;
              formattingProvider = "ormolu";
              plugin = {
                stan = {
                  globalOn = true;
                };
                eval = {
                  globalOn = true;
                };
                semanticTokens = {
                  globalOn = true;
                };
              };
            };
          };
        };
        nixd = {
          command = "nixd";
          rootPatterns = [ ".nixd.json" ];
          filetypes = [ "nix" ];
        };
        prolog = {
          command = "swipl";
          args = [
            "-g"
            "use_module(library(lsp_server))."
            "-g"
            "lsp_server:main"
            "-t"
            "halt"
            "--"
            "stdio"
          ];
          rootPatterns = [
            "pack.pl"
            "*.pl"
            "*.pro"
            "*.prolog"
          ];
          filetypes = [ "prolog" ];
        };
      };
      clangd.inlayHints.enable = true;
      clangd.fallbackFlags = [ "-std=c++20" ];
      semanticTokens.enable = true;
      codeLens.enable = true;
    };
  };
}
